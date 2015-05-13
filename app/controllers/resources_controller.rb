# Published under the MIT License http://www.opensource.org/licenses/mit-license.php
# Copyright (c) 2009, Swirrl IT Ltd., http://www.swirrl.com
#
class ResourcesController < ApplicationController


  def show
    Rails.logger.info('Resources show')
    logger.warn "*** BEGIN RAW REQUEST HEADERS ***"
    self.request.env.each do |header|
      logger.warn "HEADER KEY: #{header[0]}"
      logger.warn "HEADER VAL: #{header[1]}"
    end
    logger.warn "*** END RAW REQUEST HEADERS ***"

    # path = params[:anyroute]
    path = env['PATH_INFO']

    full_path = File.join(File.expand_path('.'),'repo_aligner','repo','purl.imsglobal.org', path )

    extension = get_extension(full_path)

    if extension.blank?
      full_file_path = choose_linked_data_file(full_path)
      if full_file_path.present?
        full_path = full_file_path
        # try again with revised path
        extension = '.' + get_extension(full_path)
        Rails.logger.info("Resolving to: #{full_path}")
      else
        Rails.logger.info("No such file")
        (render nothing: 'No such file', status: 404) and return
      end
    end

    Rails.logger.info("Rendering: #{full_path}")
    case extension
      when '.html'
        render html: get_contents(full_path).html_save
      when '.rdf'
        render text: get_contents(full_path), content_type: 'application/rdf'
      when '.ttl'
        render text: get_contents(full_path), content_type: 'application/turtle'
      when '.jsonld'
        render text: get_contents(full_path), content_type: 'application/ld+json'
      when '.json'
        render text: get_contents(full_path), content_type: 'application/json'
      else
        render text: 'No matchng RDF file extensions', status: 404
    end
  end

  private

  def choose_linked_data_file(full_path)
    result = nil
    filemap_by_ext = create_filemap_by_ext(full_path)
    last_zone = full_path.split('/')[-1]
    Rails.logger.info("Choose #{full_path} from #{filemap_by_ext.inspect}")
    if filemap_by_ext.has_key? '.rdf'
      return validate_file_present(last_zone, filemap_by_ext, '.rdf')
    elsif filemap_by_ext.has_key? '.ttl'
      return validate_file_present(last_zone, filemap_by_ext, '.ttl')
    elsif filemap_by_ext.has_key? '.n3'
      return validate_file_present(last_zone, filemap_by_ext, '.n3')
    elsif filemap_by_ext.has_key? '.jsonld'
      return validate_file_present(last_zone, filemap_by_ext, '.jsonld')
    elsif filemap_by_ext.has_key? '.json'
      return validate_file_present(last_zone, filemap_by_ext, '.json')
    end
  end

  def create_filemap_by_ext(full_path)
    files = Dir["#{full_path}/*"]
    filemap_by_ext = {}
    files.each do |file|
      basename = File.basename(file)
      extension = File.extname(file)
      unless filemap_by_ext.has_key? (extension)
        filemap_by_ext[extension] = []
      end
      filemap_by_ext[extension] << file
    end
    filemap_by_ext
  end

  def create_resource_web_path(full_file_path, leading_web_path)
    web_start_pos = full_file_path.index(leading_web_path)
    full_file_path[web_start_pos..-1]
  end

  def get_contents(path)
     contents = File.open(path, 'r') {|f| f.read}
    contents
  end

  def get_extension(path)
    last_zone = path.split('/')[-1]
    zones = last_zone.split('.')
    extension = (zones.length > 1) ? zones[-1] : nil
  end

  def validate_file_present(filename, filemap_by_ext, extension)
    files_by_ext = filemap_by_ext[extension]
    # files_by_ext.sort![0]
    target_file = "#{filename}#{extension}"
    files_by_ext.include?(target_file) ? target_file : nil
    full_path_array = files_by_ext.select {|file| file.downcase.end_with? target_file.downcase}
    (full_path_array.length > 0) ? full_path_array[0] : nil
  end

end