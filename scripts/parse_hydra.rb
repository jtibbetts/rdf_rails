
PROJECT_BASE = File.expand_path('..')

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'development'

require File.expand_path('../../config/environment', __FILE__)

require 'rdf'
require 'json/ld'

queryable = RDF::Repository.load(File.expand_path("~/git/purl_redirector/data/purl.imsglobal.org/vocab/cbe/v1/cbegreen/cbegreen.ttl"))

sse = SPARQL.parse(
    <<-STR
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix cbegreen: <http://purl.kinexis.com:8888/vocab/cbe/v1/cbegreen#>
prefix cbegreenhydra: <http://purl.kinexis.com:8888/ctx/cbe/v1/cbegreen/hydra#>
prefix hydra: <http://www.w3.org/ns/hydra/core#>
select ?p ?o
where {
cbegreen:degree_level ?p ?o
}
STR
)
current_result = nil
# queryable.query(sse) do |result|
#   current_result = result
#   result.inspect
# end

puts queryable.query(sse)
puts 'end'