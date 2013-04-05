$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "signap/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "signap"
  s.version     = Signap::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Signap."
  s.description = "TODO: Description of Signap."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.0.beta1"
  # s.add_dependency "jquery-rails"
end
