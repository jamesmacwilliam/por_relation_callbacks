# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'por_relation_callbacks/version'

Gem::Specification.new do |spec|
  spec.name          = "por_relation_callbacks"
  spec.version       = PorRelationCallbacks::VERSION
  spec.authors       = ["James Mac William"]
  spec.email         = ["jimmy.macwilliam@gmail.com"]

  spec.summary       = %q{Plain old ruby callbacks on active record relations}
  spec.description   = %q{Handles after_add and after_remove outside of the AR callback flow to keep things that aren't directly tied to the model outside of it}
  spec.homepage      = "https://github.com/jamesmacwilliam/por_relation_callbacks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",      "~> 1.10"
  spec.add_development_dependency "rake",         "~> 10.0"
  spec.add_dependency             "railties",     ">= 4.1.0", "< 5.1"
  spec.add_dependency             "activerecord", ">= 4.0.0", "< 5.1"
  spec.add_development_dependency "rspec"
end
