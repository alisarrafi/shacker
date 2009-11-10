#namespace :doc do
#
#  desc "Extending the documentation creation to use the README.textile first"
#  namespace :app do
#    puts 'Updating README_FOR_APP'
#    from = File.join(File.dirname(__FILE__), '..', '..', 'README.textile')
#    to_dir = File.join(File.dirname(__FILE__), '..', '..', 'doc')
#    to = File.join(File.dirname(__FILE__), '..', '..', 'doc', 'README_FOR_APP')
#    `mkdir #{to_dir}`
#    `cp #{from} #{to}`
#  end
#  
#end