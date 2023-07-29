require_relative "lib/bunny/rails/version"

Gem::Specification.new do |spec|
  spec.name        = "bunny-rails"
  spec.version     = Bunny::Rails::VERSION
  spec.authors     = ["Ivan Chinenov"]
  spec.email       = ["hjvt@hjvt.dev"]
  spec.homepage    = "https://github.com/sorta-rb/bunny-rails"
  spec.summary     = "Bunny integration for Rails"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "~> 7"
  spec.add_dependency "bunny"
end
