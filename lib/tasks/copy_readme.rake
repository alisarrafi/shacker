namespace :doc do

  desc "Extending the documentation creation to use the README.textile first"
  namespace :app do
    puts 'Updating README_FOR_APP'
    from = File.join(File.dirname(__FILE__), '..', '..', 'README.textile')
    to = File.join(File.dirname(__FILE__), '..', '..', 'doc', 'README_FOR_APP')
    `cp #{from} #{to}`
  end
  
end