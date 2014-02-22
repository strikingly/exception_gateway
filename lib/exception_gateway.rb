require "exception_gateway/version"
require "exception_gateway/vendors/bugsnag"

module ExceptionGateway
  class Config
    attr_accessor :backend
  end

  class Gateway
    include ExceptionGateway::Vendors
  end
  
  def self.configure
    c = Config.new
    yield c
    @@config = c
    @@gateway = Gateway.new
  end

  def self.alert(msg, options={})
    method = "#{@@config.backend}_alert".to_s
    @@gateway.send method, msg, options
  end

  def self.transmit(exception)
    method = "#{@@config.backend}_transmit".to_s
    @@gateway.send method, exception
  end

  def self.time(msg)
    start_time = Time.now
    yield_value = yield
    end_time = Time.now
    self.alert(msg, :time => "#{(end_time - start_time) * 1000} ms")
  end
end
