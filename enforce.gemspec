lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'enforce/version'

Gem::Specification.new do |s|
  s.name        = 'enforce'
  s.version     = Enforce::VERSION
  s.date        = Date.today.to_s
  s.summary     = "DSL for enforcing folder and file contents"
  s.description = "Define rules for folder and file contents and enforce them from the command line"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ["enforce"]
  s.homepage    = 'https://github.com/DannyBen/enforce'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.0.0"

  s.add_development_dependency 'runfile', '~> 0.10'
  s.add_development_dependency 'runfile-tasks', '~> 0.4'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rspec_fixtures', '~> 0.2'
  s.add_development_dependency 'simplecov', '~> 0.15'
  s.add_development_dependency 'byebug', '~> 9.0'
end
