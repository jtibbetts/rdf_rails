
require "json/ld"

source_json = %q{

{
  "@context" : [
    {
      "res" : "http://purl.imsglobal.org/ctx/lis/v2p1/Result#"
    }
  ],
  "@type" : "Page",
  "@id" : "http://lms.example.com/sections/2923/gradebook/?firstPage",
  "nextPage" : "http://lms.example.com/sections/2923/gradebook/?p=2",
  "pageOf" : {
    "@context" : "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer",
    "@type" : "LineItemContainer",
    "membershipSubject" : {
      "@id" : "http://lms.example.com/sections/2923",
      "context_id" : "123-abc",
      "lineItem" : [
        {
          "@id" : "http://lms.example.com/sections/2923/gradebook/items/1",
          "label" : "Chapter 5 Test",
          "reportingMethod" : "res:totalScore",
          "assignedActivity" : {
            "@id" : "http://toolprovider.example.com/assessment/66400",
            "activity_id" : "a-9334df-33"
          },
          "scoreConstraints" : {
            "@type" : "NumericLimits",
            "normalMaximum" : 100,
            "extraCreditMaximum" : 10,
            "totalMaximum" : 110
          },
          "results" : "http://lms.example.com/sections/2923/gradebook/items/1/results"
        },
        {
          "@id" : "http://lms.example.com/sections/2923/gradebook/items/2",
          "label" : "Chapter 2 Essay",
          "reportingMethod" : "res:totalScore",
          "assignedActivity" : {
            "@id" : "http://toolprovider.example.com/biology/essay/2",
            "activity_id" : "d-4594wk-93"
          },
          "scoreConstraints" : {
            "@type" : "NumericLimits",
            "totalMaximum" : 100
          },
          "results" : "http://lms.example.com/sections/2923/gradebook/items/2/results"
        }
      ]
    }
  }
}

}

source_json = %q{{   "@type" : "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/Page",   "@id" : "http://lms.example.com/sections/2923/gradebook/?firstPage",   "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/nextPage" : "http://lms.example.com/sections/2923/gradebook/?p=2",   "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/pageOf" : {     "@type" : "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/LineItemContainer",     "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/membershipSubject" : {       "@id" : "http://lms.example.com/sections/2923",       "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/context_id" : "123-abc",       "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/lineItem" : [         {           "@id" : "http://lms.example.com/sections/2923/gradebook/items/1",           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/label" : "Chapter 5 Test",           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/reportingMethod" : "res:totalScore",           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/assignedActivity" : {             "@id" : "http://toolprovider.example.com/assessment/66400",             "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/activity_id" : "a-9334df-33"           },           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/scoreConstraints" : {             "@type" : "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/NumericLimits",             "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/normalMaximum" : 100,             "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/extraCreditMaximum" : 10,             "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/totalMaximum" : 110           },           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/results" : "http://lms.example.com/sections/2923/gradebook/items/1/results"         },         {           "@id" : "http://lms.example.com/sections/2923/gradebook/items/2",           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/label" : "Chapter 2 Essay",           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/reportingMethod" : "res:totalScore",           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/assignedActivity" : {             "@id" : "http://toolprovider.example.com/biology/essay/2",             "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/activity_id" : "d-4594wk-93"           },           "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/scoreConstraints" : {             "@type" : "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/NumericLimits",             "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/totalMaximum" : 100           },           "results" : "http://lms.example.com/sections/2923/gradebook/items/2/results"         }       ]     }   } } }

input = JSON.parse source_json

puts "********Expanded************"
puts JSON.pretty_generate( JSON::LD::API.expand(input) )


puts "********Compacted************"
context = JSON.parse(%({
  "@context": {
    "lineitemcontainer": "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/"
  }
}))['@context']
puts JSON.pretty_generate( JSON::LD::API.compact(input, context) )


puts "********Turtle************"
graph = RDF::Graph.new << JSON::LD::API.toRdf(input)

require 'rdf/turtle'
puts( graph.dump(:ttl, :prefixes => {:lineitemcontainer => "http://purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/"}) )
