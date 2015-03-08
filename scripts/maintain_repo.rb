
PROJECT_BASE = File.expand_path('..')

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'development'

require File.expand_path('../../config/environment', __FILE__)

ancestor_node = File.join(PROJECT_BASE, 'repo')

def tree_of_paths(ancestor_node)
  paths = []

  directories = []
  Dir.glob("#{ancestor_node}/**/*/") do |path|
    directories << path[ancestor_node.length..-2]
  end

  directories.each do |directory|

    dirname = File.join(ancestor_node, directory)
    Dir.entries(dirname).each do |entry|
      unless entry =~ /^\..*/
        path = File.join(dirname, entry)
        if File.file?(File.join(dirname, entry))
          paths << path[ancestor_node.length+1..-1]
        end
      end
    end
  end

  paths
end

def rewrite_file(filename, old_str, new_str)
  contents = nil
  File.open(filename, 'rb') do |f|
    contents = f.read
  end

  new_contents = contents.gsub old_str, new_str

  File.open(filename, 'wb') do |f|
    f.write new_contents
  end

  puts "Fixed"
end

def relocate_prefixes(ancestor_node, is_local_not_purl)
  paths = tree_of_paths(ancestor_node)
  paths.each do |path|
    filename = File.join(ancestor_node, path)
    if is_local_not_purl
      rewrite_file(filename, 'http://purl.imsglobal.org', 'http://localhost/purl.imsglobal.org')
    else
      rewrite_file(filename, 'http://localhost/purl.imsglobal.org', 'http://purl.imsglobal.org')
    end
  end
end

relocate_prefixes(ancestor_node, true)