
PROJECT_BASE = File.expand_path('..')

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'development'

require File.expand_path('../../config/environment', __FILE__)

require 'rdf'
require 'json/ld'
fn=File.expand_path("~/git/purl_redirector/data/purl.imsglobal.org/ctx/cbe/v1/cbegreen/hydra/hydra.jsonld")
f=File.new(fn)
json_str = f.read
json_obj = JSON.load(json_str)
puts json_obj['supportedClass']

