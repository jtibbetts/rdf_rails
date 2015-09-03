# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# +++++++++++++ Extra line needed for the RDF content negotiation example ++++++++++++++++
# need this so we can use respond_to with '.rdf'
Mime::Type.register("application/rdf+xml", :rdf)
Mime::Type.register("text/rdf", :rdf)
Mime::Type.register("application/turtle", :ttl)
Mime::Type.register("application/rdf+n3", :n3)
Mime::Type.register("application/json", :jsonld)
Mime::Type.register("application/jsonld", :jsonld)
