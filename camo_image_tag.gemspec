$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "camo_image_tag/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "camo_image_tag"
  s.version     = CamoImageTag::VERSION
  s.authors     = ["Jason Garber"]
  s.email       = ["jg@jasongarber.com"]
  s.homepage    = "https://github.com/jgarber/camo_image_tag"
  s.summary     = "Rails plugin to rewrite image_tags for camo"
  s.description = "Any absolute URL you pass to image_tag will be rewritten if it is not https."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency 'rails', '~> 3.0'
  s.add_development_dependency 'rspec', '~> 2.10.0'
end
