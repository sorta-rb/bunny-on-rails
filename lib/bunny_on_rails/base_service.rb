# frozen_string_literal: true

module BunnyOnRails
  class BaseService
    include ::Singleton
    class << self
      private :instance
      def init!
        @instance ||= instance
        ready?
      end

      def setup(&block)
        private define_method(:initialize, &block)
      end

      def ready?
        @instance.present?
      end

      private

      def threaded_initializer(name, private: false)
        define_singleton_method(name) do |&block|
          Thread.current[:"#{self.class.name}_#{name}"] ||= instance_eval(&block)
        end
        private_class_method name if private
      end

      def forward!(method)
        define_singleton_method(method) do |*args, **kwargs, &block|
          @instance.send(method, *args, **kwargs, &block)
        end
      end

      def provides(*attrs)
        attrs.each do |attr|
          provide attr
        end
      end

      def provide(attr, &block)
        block ||= proc do
          instance_variable_get(:"@#{attr}")
        end

        define_singleton_method(attr) do
          @instance.instance_eval(&block)
        end
      end
    end
  end
end
