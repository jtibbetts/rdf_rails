class TestTurtle
  require "rdf"
  require "rdf/turtle"
  require "json/ld"
  require 'rdf/rdfxml'

  FILENAME = 'simpsons'

  prefixes = {
      simp: "http://rdf.kinexis.com/simpsons",
      foaf:  "http://xmlns.com/foaf/0.1",
      # dbont:  "http://dbpedia.org/ontology",
      bio:  "http://purl.org/vocab/bio/0.1",
      # w3:  "http://www.w3.org/2000/01/rdf-schema#",
      schema: "http://schema.org"
  }

  def self.output_to_file(content, ext)
    File.open("../public/#{FILENAME}.#{ext}.txt", "w") do |f|
      f.write(content)
    end
  end

  RDF::Turtle::Reader.open("../data/#{FILENAME}.ttl",
                           prefixes:  prefixes) do |r|

    output_to_file(r.dump(:ntriples, :standard_prefixes => true, :validate => false), 'ntriples')

    r.rewind
    output_to_file(r.dump(:nquads, :standard_prefixes => true), 'nquads')

    r.rewind
    output_to_file(r.dump(:turtle, :standard_prefixes => true), 'turtle')

    r.rewind
    output_to_file(r.dump(:rdfxml, :standard_prefixes => true), 'rdfxml')

    r.rewind
    output_to_file(r.dump(:jsonld, :standard_prefixes => true), 'jsonld')

  end
end