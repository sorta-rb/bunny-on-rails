# frozen_string_literal: true

module Bunny
  class BunnyGenerator < ::Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)
    check_class_collision suffix: 'Service'

    def make_service
      say_status 'status', 'hello'
      template 'bunny_service.rb.tt', "app/services/#{file_name}.rb"
    end

    def add_service_to_initializer
      insert_into_file 'config/application.rb', "#{class_name}.setup!", after: 'ApplicationGateway.setup!'
    end
  end

  # This generator creates default config file for bunny-rails
  class InstallGenerator < ::Rails::Generators::Base
    desc 'Generate default config for bunny-rails'
    source_root File.expand_path('templates', __dir__)

    def create_default_config
      template 'bunny.yml', 'config/bunny.yml'
      say 'Insert configuration into config/application.rb'
      environment <<-RUBY
        config.after_initialize do
          ApplicationGateway.init!
        end
      RUBY
      environment 'config.bunny = config_for(:bunny)'
    end

    def create_application_gateway
      copy_file 'application_gateway.rb', 'app/services/application_gateway.rb'
    end
  end
end
