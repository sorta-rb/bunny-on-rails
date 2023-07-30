# frozen_string_literal: true

class BunnyHandler < YARD::Handlers::Ruby::Base
  handles method_call
  namespace_only

  def self.handles?(stmt)
    super &&
      case name = stmt.method_name(true)
      when :forward!, :threaded_initializer, :provide, :provides
        true
      else
        initializer?(stmt, name)
      end
  end

  def self.initializer?(stmt, name)
    YARD::Registry.at(stmt.parent&.parent&.class_name&.source)&.meths&.find do
      _1.name == name
    end&.send(:[], :threaded_initializer)
  end

  process do
    case name = statement.method_name(true)
    when :forward!
      process_forward!
    when :threaded_initializer
      process_threaded_initializer
    when :provide
      process_provide(first_arg)
    when :provides
      process_provides
    else
      handle_initializer_call(name)
    end
  end

  def process_provide(name)
    object = YARD::CodeObjects::MethodObject.new(namespace, name, :class)
    object.docstring = "Provides read-only access to singleton instance's @#{name} property"
    register(object)
  end

  def process_provides
    statement.parameters.take_while { _1 != false }.map { _1.jump(:tstring_content, :ident).source }.each do |name|
      process_provide(name)
    end
  end

  def first_arg
    statement.parameters.first.jump(:tstring_content, :ident).source
  end

  def process_forward!
    parse_block(statement[1][0])
    name = first_arg
    object = YARD::CodeObjects::MethodObject.new(namespace, name, :class)
    object.parameters = YARD::Registry.at("#{namespace}##{name}").parameters
    object.docstring = "Calls {##{name}} on the singleton instance"
    register(object)
  end

  def process_threaded_initializer
    name = first_arg
    register YARD::CodeObjects::MethodObject.new(namespace, name, :class) do |o|
      o.private = true
      o.parameters = [%w[&body]]
      o[:threaded_initializer] = true
      o.docstring = "Defines an initializer for a thread-local #{name}"
    end
  end

  def handle_initializer_call(name)
    meth = register YARD::CodeObjects::MethodObject.new(namespace, name, :instance) do |o|
      o.docstring = "Returns thread-local #{name}, creating one if it doesn't already exist"
    end

    namespace.attributes[:instance][name] = { read: meth }
  end
end
