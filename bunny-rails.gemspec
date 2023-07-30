# frozen_string_literal: true

require_relative 'lib/bunny_on_rails/version'

Gem::Specification.new do |spec|
  spec.name        = 'bunny-rails'
  spec.version     = BunnyOnRails::VERSION
  spec.authors     = ['Ivan Chinenov']
  spec.email       = ['hjvt@hjvt.dev']
  spec.homepage    = 'https://github.com/sorta-rb/bunny-rails'
  spec.summary     = 'Bunny integration for Rails'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.2'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'bunny'
  spec.add_dependency 'rails', '~> 7'
end
