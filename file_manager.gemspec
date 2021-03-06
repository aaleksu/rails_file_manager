$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "file_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "file_manager"
  s.version     = FileManager::VERSION
  s.authors     = ["Alex Anisimov"]
  s.email       = ["a.aleksu@gmail.com"]
  s.homepage    = "https://github.com/aaleksu/rails_file_manager"
  s.summary     = "File manager"
  s.description = "Uploading files (and creating thumbs for images); still in development"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_dependency "rails", "~> 3.2.3"

  s.add_dependency 'rmagick'

  s.add_development_dependency "sqlite3"
end
