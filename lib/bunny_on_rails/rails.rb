# frozen_string_literal: true

require_relative 'version'
require_relative 'base_service'
require_relative 'base_channel_service'

module BunnyOnRails
  module Rails
    class Railtie < ::Rails::Railtie
      generators do
        require_relative 'generators/bunny'
      end
    end
  end
end
