require File.expand_path('../lib/lang/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'lang'
  s.version     = Lang::VERSION
  s.date        = '2015-12-17'
  s.summary     = "a simple language for a simple human"
  s.description = "a simple language for a simple human"
  s.authors     = ["♥"]
  s.email       = 'hi@drwrf.com'
  s.license     = 'MIT'

  s.require_paths    = ["lib"]
  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec}/*`.split("\n")

  s.add_development_dependency "rspec"
end
