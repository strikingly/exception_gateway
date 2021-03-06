require 'active_support'

module ExceptionGateway
  # Which exception backend you wanna wrap.
  # Value must be either +:bugsnag+ or +:sentry+
  mattr_accessor :backend

  # Secret key to connect to an alternative room on the backend API
  # Used to not pollute critical errors with alerts
  mattr_accessor :alert_api_key

  @@adapter = nil

  class << self
    def configure
      yield self
    end

    def alert(msg, options = {})
      adapter.alert(msg, options)
    end

    def transmit(exception)
      adapter.transmit(exception)
    end

    def time(msg)
      start_time = Time.now
      yield_value = yield if block_given?
      end_time = Time.now
      alert(msg, :time => "#{(end_time - start_time) * 1000} ms")
    end

    private

    def adapter
      return @@adapter if @@adapter

      if backend.nil?
        raise InvalidAdapterError.new("You didn't specify any backed (nil)")
      end

      adapter_require = "exception_gateway/adapters/#{backend}_adapter"
      adapter_file = "#{File.expand_path(adapter_require, File.dirname(__FILE__))}.rb"

      raise InvalidAdapterError.new("Unknow adapter: #{backend}") unless File.exists?(adapter_file)

      require adapter_require

      adapter_klass = Adapters.const_get("#{backend.to_s.capitalize}Adapter")

      @@adapter = adapter_klass.new(
        :alert_api_key  => alert_api_key
      )
    end
  end
end

require_relative 'exception_gateway/adapters/abstract_adapter'
require_relative 'exception_gateway/errors/standard_error'
require_relative 'exception_gateway/errors/invalid_adapter_error'
