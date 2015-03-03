
PROJECT_BASE = File.expand_path('..')

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'development'

require File.expand_path('../../config/environment', __FILE__)

# directories = []
# Dir.glob('../repo/**/*/') do |path|
#   directories << path[8..-2]
# end
#
# def file_content(directory)
#   dirname = File.join(PROJECT_BASE, 'repo', directory)
#   files = []
#   Dir.entries(dirname).each do |entry|
#     unless entry =~ /^\..*/
#       if File.file?(File.join(dirname, entry))
#         files << entry
#       end
#     end
#   end
#   files
# end
#
# directories.each {|d| puts "#{d}: #{file_content(d)}"}directories = []

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

puts tree_of_paths('../repo')