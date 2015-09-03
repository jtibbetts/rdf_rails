# Published under the MIT License http://www.opensource.org/licenses/mit-license.php
# Copyright (c) 2009, Swirrl IT Ltd., http://www.swirrl.com
#
class ResourcesController < ApplicationController


  def show
    Rails.logger.info('Resources show')
    # path = params[:anyroute]
    path = env['PATH_INFO']

    full_path = File.join(File.expand_path('.'),'repo_aligner','repo','purl.imsglobal.org', path )

    last_zone = full_path.split('/')[-1]
    zones = last_zone.split('.')
    extension = (zones.length > 1) ? zones[-1] : nil

    accept_header = ENV['HTTP_ACCEPT']

    if extension.present?
      # either the html or rdf representation has been asked for directly, so provide it
      contents = File.open(full_path, 'r') {|f| f.read}

      Rails.logger.info("Rendering: #{full_path}")
      respond_to do |format|
        format.html {
          render html: get_contents(full_path).html_save }
        format.rdf {
          render text: get_contents(full_path), content_type: 'application/rdf'}
        format.ttl {
          render text: get_contents(full_path), content_type: 'application/turtle'}
        format.hydra_json {
          render text: get_contents(full_path), content_type: 'application/json' }
        format.jsonld {
          render text: get_contents(full_path), content_type: 'application/jsonld' }
        # an alternative here is to call your own method to output the required RDF as a string
        # format.rdf {render  :text => my_method_to_make_rdf }
      end


    else
      # no format (file extension) specified, so the resource identifier has been requested. respond_to will look at HTTP Accept header
      # and do the appropriate redirected
      full_file_path = choose_linked_data_file(full_path)
      if full_file_path.present?
        resource_web_path = create_resource_web_path(full_file_path, path)
        Rails.logger.info("Redirection to: #{resource_web_path}")
        redirect_to "#{resource_web_path}", status: 303
      else
        Rails.logger.info("No such file")
        render nothing: 'No such file', status: 404
      end
    end

  end

  private

  def choose_linked_data_file(full_path)
    result = nil
    filemap_by_ext = create_filemap_by_ext(full_path)
    Rails.logger.info("Choose #{full_path} from #{filemap_by_ext.inspect}")
    if filemap_by_ext.has_key? '.rdf'
      return get_first_file(filemap_by_ext, '.rdf')
    elsif filemap_by_ext.has_key? '.ttl'
      return get_first_file(filemap_by_ext, '.ttl')
    elsif filemap_by_ext.has_key? '.n3'
      return get_first_file(filemap_by_ext, '.n3')
    elsif filemap_by_ext.has_key? '.jsonld'
      return get_first_file(filemap_by_ext, '.jsonld')
    elsif filemap_by_ext.has_key? '.json'
      return get_first_file(filemap_by_ext, '.json')
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

  def get_first_file(filemap_by_ext, extension)
    files_by_ext = filemap_by_ext[extension]
    files_by_ext.sort![0]
  end
end