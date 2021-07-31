require_relative "lib/api_sabeq_ps_v1/version"

Gem::Specification.new do |spec|
  spec.name          = "api_sabeq_ps_v1"
  spec.version       = ApiSabeqPsV1::VERSION
  spec.authors       = ["ShaimaKaraki"]
  spec.email         = ["shaimakaraki@gmail.com"]

  spec.summary       = "gem for sabeq.ps API helper functionalities"
  spec.description   = "Its a gem for sabeq.ps API helper functionalities"
  spec.homepage      = "https://github.com/ShaimaKaraki/s_api.git"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.files       = ["lib/api_sabeq_ps_v1.rb", "lib/api_sabeq_ps_v1/version.rb", "lib/api_sabeq_ps_v1/sabeq_helpers.rb", "lib/api_sabeq_ps_v1/railtie.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
