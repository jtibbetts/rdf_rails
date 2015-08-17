class DocumentsController < ApplicationController
  def show
    fn=File.expand_path("~/git/purl_redirector/data/purl.imsglobal.org/ctx/cbe/v1/cbegreen/hydra/hydra.jsonld")
    f=File.new(fn)
    json_str = f.read
    @json = JSON.load(json_str)
    render "documents/show"
  end
end
