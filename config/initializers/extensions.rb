Dir.glob(File.join Rails.root, 'lib', '*.rb') { |file| require file }
