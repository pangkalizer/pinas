# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pinas/version'

Gem::Specification.new do |spec|
  spec.name          = "pinas"
  spec.version       = Pinas::VERSION.dup
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Allan Andal"]
  spec.email         = ["allan.andal@gmail.com"]
  spec.summary       = %q{Provide Philippines locations.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/pangkalizer/pinas"
  spec.license       = "MIT"
  spec.rubyforge_project = "pinas"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"
  spec.add_dependency "railties", ">= 3.2.6", "< 5"
  spec.add_dependency "geocoder", "~> 1.2"
  spec.add_dependency "awesome_nested_set", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
