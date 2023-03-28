lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enforce/version'

Gem::Specification.new do |s|
  s.name        = 'enforce'
  s.version     = Enforce::VERSION
  s.summary     = 'DSL for enforcing folder and file contents'
  s.description = 'Define rules for folder and file contents and enforce them from the command line'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['enforce']
  s.homepage    = 'https://github.com/DannyBen/enforce'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.7.0'

  s.add_runtime_dependency 'pretty_trace', '~> 0.2'
  s.metadata['rubygems_mfa_required'] = 'true'
end
