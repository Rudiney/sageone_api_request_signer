# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sageone_api_request_signer/version'

Gem::Specification.new do |spec|
  spec.name          = "sageone_api_request_signer"
  spec.version       = SageoneApiRequestSigner::VERSION
  spec.authors       = ["Rudiney Altair Franceschi"]
  spec.email         = ["rudi.atp@gmail.com"]
  spec.summary       = %q{Sign requests call to SageOne API.}
  spec.description   = %q{Sign requests call to SageOne API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'fudge'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'flay'
  spec.add_development_dependency 'ruby2ruby' # dependency of flay, which doesn't use a gemspec
  spec.add_development_dependency 'flog'
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'simplecov'

  spec.add_development_dependency 'rest_client' # integration test do real api calls

end
