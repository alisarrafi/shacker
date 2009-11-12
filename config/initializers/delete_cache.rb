ASSET_CACHES = [File.join(Rails.root, 'public', 'javascripts', 'shacker.js'),
                File.join(Rails.root, 'public', 'stylesheets', 'shacker.css'),]

ASSET_CACHES.each do |file|
  File.delete file if File.exists? file
end