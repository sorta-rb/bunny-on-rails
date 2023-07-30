class ApplicationGateway < BunnyOnRails::BaseService
  provide :connection

  setup do
    @connection = Bunny.new(**Rails.configuration.bunny)
    @connection.start
  end
end
