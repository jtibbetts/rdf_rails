class DocumentsController < ApplicationController
  URL_PATTERN = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  require 'httparty'

  def show
    path_to_hydra = params[:path_to_hydra]
    full_path_to_repo = "#{Rails.application.config.repo_baseurl}/#{path_to_hydra}"
    response = HTTParty.get(full_path_to_repo)
    unless response.code == 200
      render text: "Hydra repo access error: #{response.message}" and return
    end
    @hydra_json = JSON.load(response)

    @hydra_json.each_pair do |k,v|
      if k =~ /.*?contextURI$/
        @context_uri = v
      end
    end

    response = HTTParty.get(@context_uri)
    unless response.code == 200
      render text: "Context repo access error: #{response.message}" and return
    end
    @context_json = JSON.load(response)

    @baseurl_by_prefix = extract_prefixes(@hydra_json)
    @baseurl_by_prefix['rdf'] = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' unless @baseurl_by_prefix.include? 'rdf'
    @baseurl_by_prefix['rdfs'] = 'http://www.w3.org/2000/01/rdf-schema#' unless @baseurl_by_prefix.include? 'rdfs'
    @baseurl_by_prefix['owl'] = 'http://www.w3.org/2002/07/owl#' unless @baseurl_by_prefix.include? 'owl'
    @prefix_by_baseurl = @baseurl_by_prefix.invert

    # expand and recompact with no context
    @hydra_json = JSON::LD::API.compact(JSON::LD::API.expand(@hydra_json), {})

    # get remote context (only)..last string URI in @context array
    @vocab_uri = nil
    context_element = @context_json['@context']
    if context_element.present?
      if context_element.kind_of?(String)
        @vocab_uri = context_element
      elsif context_element.kind_of?(Array)
        context_array = context_element.reverse
        context_array.each do |element|
          if element.kind_of?(String)
            @vocab_uri = element
            break
          end
        end
      end
    else
      render text: "Missing @context element within context file" and return
    end
    if @vocab_uri.nil?
      render text: "Can't find remote reference within @context" and return
    end

    # response = HTTParty.get(@vocab_uri)
    # unless response.code == 200
    #   render text: "Vocab repo access error: #{response.message}" and return
    # end

    queryable = RDF::Graph.load(@vocab_uri)

    @vocab_json = get_all_field_info_from_tstore(queryable)

    # merge and recollapse
    hydra_prefix = @baseurl_by_prefix['hydra']
    @hydra_json["#{hydra_prefix}supportedClass"].each do |supportedClass|
      supported_property_array = supportedClass["#{hydra_prefix}supportedProperty"]
      if supported_property_array.kind_of? (Hash)
        supported_property_array = [supported_property_array]
      end
      supported_property_array.each do |supportedProperty|
        target_class = supportedClass['@id']
        vocab_property = supportedProperty["#{hydra_prefix}property"]
        if vocab_property.present?
          target_property = vocab_property['@id']
          if target_property.present?
            vocab_properties = get_vocab_properties(target_class, target_property)
            supportedProperty.merge! vocab_properties
          end
        end
      end
    end

    render "documents/show"
  end

  protected

  def get_all_field_info_from_tstore(queryable)
    sparql_statement = ''
    sparql_statement += collect_prefix_section(@baseurl_by_prefix)
    sparql_statement += <<-STR
    select ?klass ?restriction ?prop ?value
where {
?klass rdf:type owl:Class.
?klass rdfs:subClassOf ?restriction.
?restriction ?prop ?value
}
STR

    puts sparql_statement.inspect

    sse = SPARQL.parse(sparql_statement)

    field_info_by_class = {}
    queryable.query(sse) do |result|
      klass = result[:klass]
      restriction = result[:restriction]
      property = result[:prop]
      value = result[:value]
      puts "#{klass}, #{restriction} #{property} #{value}"

      unless field_info_by_class.include?(klass)
        field_info_by_class[klass] = {}
      end
      unless field_info_by_class[klass].include?(restriction)
        field_info_by_class[klass][restriction] = {}
      end
      field_info_by_class[klass][restriction][property] = value
    end

    klasses = field_info_by_class.keys
    klasses.each do |klass|
      field_info_by_class[klass].keys.each do |restriction|
        restrictions_hash = field_info_by_class[klass][restriction]
        (fieldname, fields_hash) = remap_restrictions_to_fieldnames(restrictions_hash)
        field_info_by_class[klass].delete(restriction)
        field_info_by_class[klass][fieldname] = fields_hash
      end
    end

    field_info_by_class
  end

  def collect_prefix_section(baseurl_by_prefix)
    prefix_section = ''
    baseurl_by_prefix.each_pair do |k,v|
      prefix_section += "prefix #{k}: <#{v}>\n"
    end
    prefix_section
  end

  def get_vocab_properties(target_class, target_property)
    result = {}
    vocab_element = @vocab_json[target_class]
    if vocab_element.present?
      properties = vocab_element[target_property]
      if properties.present?
        result = properties
      end
    end
    result
  end

  def extract_prefixes(hydra_json_ld)
    prefixes = {}
    context = hydra_json_ld['@context']
    context.each_pair do |k,v|
      if v =~ URL_PATTERN
        prefixes[k] = v
      end
    end
    prefixes
  end

  def remap_restrictions_to_fieldnames(restrictions_hash)
    # recreate all_fields with key being the onProperty value (ie fieldname)
    on_property_uri = RDF::URI.new("#{@baseurl_by_prefix['owl']}onProperty")
    property_name = restrictions_hash[on_property_uri]
    fieldnames_hash = {}
    restrictions_hash.each_pair do |k,v|
      unless k == on_property_uri
        fieldnames_hash[k] = v
      end
    end
    [property_name, fieldnames_hash]
  end
end
