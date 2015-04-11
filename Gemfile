source 'https://rubygems.org'

gem 'rails', '4.1.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
gem 'mysql2', '~> 0.3.13'

gem 'activeadmin', github: 'gregbell/active_admin'

gem 'jquery-ui-rails'
gem 'jquery-turbolinks'

# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

gem 'haml-rails'
gem 'nokogiri'

gem 'rdf'
gem 'rdf-turtle'
gem 'json-ld'
gem 'rdf-rdfxml'


group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  # gem 'pry-plus'
  # the following components of pry-plus now have to be listed separately
  # so that pry-debugger, which uses debugger, which doesn't compile under
  # ruby 2.1.2, can be replaced with pry-byebug
  gem 'bond'
  gem 'jist'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-docmore'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'pry-remote'
end


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
