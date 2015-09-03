
require 'rdf'
require 'rdf/turtle'
require 'json/ld'
require 'sparql'

@baseurl_by_prefix = {
    rdf: "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
    rdfs: "http://www.w3.org/2000/01/rdf-schema#",
    owl: "http://www.w3.org/2002/07/owl#",
    cbegreen: "http://purl.kinexis.com:8888/vocab/cbe/v1/cbegreen#",
    cbegreenhydra: "http://purl.kinexis.com:8888/ctx/cbe/v1/cbegreen/hydra#",
    hydra: "http://www.w3.org/ns/hydra/core#"
}

@prefix_by_baseurl = @baseurl_by_prefix.invert

fname = "/Users/johntibbetts/git/purl_redirector/data/purl.imsglobal.org/vocab/cbe/v1/cbegreen/cbegreen.ttl"

def compactify(element)
  rdfuri = element.canonicalize
  rdfhash = rdfuri.object
  fragment = rdfhash[:fragment]
  baseurl= "#{rdfhash[:scheme]}://#{rdfhash[:authority]}#{rdfhash[:path]}#"
  if @prefix_by_baseurl.include? baseurl
    prefix = @prefix_by_baseurl[baseurl]
  else
    prefix = baseurl
  end
  puts "#{prefix}:#{fragment}"
end

# queryable = RDF::Turtle::Reader.open(fname, prefixes: current_prefixes) do |r|
#   r.each_statement {|stmt| puts stmt.to_s}
# end

queryable = RDF::Repository.load(fname)

sse = SPARQL.parse(
    <<-STR
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix cbegreen: <http://purl.kinexis.com:8888/vocab/cbe/v1/cbegreen#>
prefix cbegreenhydra: <http://purl.kinexis.com:8888/ctx/cbe/v1/cbegreen/hydra#>
prefix hydra: <http://www.w3.org/ns/hydra/core#>
select ?p ?o
where {
cbegreen:degree_level ?p ?o
}
STR )

results = []
queryable.query(sse) do |result|
  results << result
end


# puts results[0][:s].to_s
# puts results[0][:p].to_s
# puts results[0][:o].to_s
# puts results[1][:s].to_s
# puts results[1][:p].to_s
# puts results[1][:o].to_s

compactify(results[0][:p])
compactify(results[0][:o])

