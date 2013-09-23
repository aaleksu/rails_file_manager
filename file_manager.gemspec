$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "file_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "file_manager"
  s.version     = FileManager::VERSION
  s.authors     = ["Alex Anisimov"]
  s.email       = ["a.aleksu@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of FileManager."
  s.description = "TODO: Description of FileManager."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_dependency "rails", "~> 3.2.3"

  s.add_development_dependency "sqlite3"
end
