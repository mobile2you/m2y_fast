
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "m2y_fast/version"

Gem::Specification.new do |spec|
  spec.name          = "m2y_fast"
  spec.version       = M2yFast::VERSION
  spec.authors       = ["Caio Lopes"]
  spec.email         = ["caio.lopes@mobile2you.com.br"]

  spec.summary       = %q{Fast Gem}
  spec.description   = %q{Fast Gem}
  spec.homepage      = "http://www.mobile2you.com.br"
  spec.license       = "MIT"


  spec.files = Dir['lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "openssl"
  spec.add_runtime_dependency "savon"
  spec.add_runtime_dependency 'activesupport', '~> 6.1.3.1'
end
