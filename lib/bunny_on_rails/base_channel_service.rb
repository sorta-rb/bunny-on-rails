# frozen_string_literal: true

module BunnyOnRails
  class BaseChannelService < BunnyOnRails::BaseService
    threaded_initializer :channel
    threaded_initializer :exchange
    threaded_initializer :queue

    class << self
      def init!
        @instance ||= instance
        @instance.queue.bind(@instance.exchange)
        @instance.queue.subscribe do |delivery_info, properties, message|
          @instance.on_receive(message, properties, delivery_info)
        end
        ready?
      end

      private

      def on_recieve(&block)
        define_method(:recieved) do |message, properties, delivery_info|
          Rails.application.reloader.wrap do
            block.yield(message, properties, delivery_info)
          end
        end
        private :recieved
      end
    end
  end
end
