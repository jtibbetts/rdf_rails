
PROJECT_BASE = File.expand_path('..')

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'development'

require File.expand_path('../../config/environment', __FILE__)

require 'rdf'
require 'json/ld'

include RDF

# fname="/Users/johntibbetts/git/purl_redirector/data/purl.imsglobal.org/ctx/cbe/v1/cbe.collapse.ttl"
# fname = "/Users/johntibbetts/git/purl_redirector/data/purl.imsglobal.org/samples/cbe/record_of_performance.jsonld"
fname = "/Users/johntibbetts/git/purl_redirector/data/purl.imsglobal.org/vocab/cbe/v1/cbegreen/cbegreen2.ttl"
# graph = RDF::Graph.load(fname, format: :jsonld)
#

# input = JSON.parse(File.read(fname))
# graph = RDF::Graph.new << JSON::LD::API.toRdf(input)

graph = RDF::Graph.load(fname, format: :ttl)

statements = []
RDF::Reader.open(fname) do |reader|
  reader.each_statement do |statement|
    statements << statement
  end
end

statements_by_temp_subject = {}
statements.each do |statement|
  if (/_:node/.match (statement.subject.to_s)).present?
    if !(statements_by_temp_subject.has_key? statement.subject)
      statements_by_temp_subject[statement.subject] = []
    end
    statements_by_temp_subject[statement.subject] << statement
  end
end

statements_by_temp_object = {}
statements.each do |statement|
  object_name = statement.object.to_s
  if (/_:node/.match(object_name)).present?
    if !(statements_by_temp_object.has_key? statement.object)
      statements_by_temp_object[statement.object] = []
    end
    statements_by_temp_object[statement.object] << statement
  end
end

graph = RDF::Graph.new
graph.insert(statements)

puts graph.dump(:ttl)