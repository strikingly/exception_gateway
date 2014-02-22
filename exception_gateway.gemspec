# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exception_gateway/version'

Gem::Specification.new do |spec|
  spec.name          = "exception_gateway"
  spec.version       = ExceptionGateway::VERSION
  spec.authors       = ["Li Zhenchao"]
  spec.email         = ["leezhenchao@gmail.com"]
  spec.description   = %q{A wrapper for error reporting services}
  spec.summary       = %q{A wrapper for error reporting services, currently only bugsnag is supported}
  spec.homepage      = "https://github.com/strikingly/exception_gateway"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 0"
  spec.add_development_dependency "rspec", "~> 2.6"
end
