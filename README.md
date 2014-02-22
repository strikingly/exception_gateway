# ExceptionGateway

[![Build Status](https://travis-ci.org/strikingly/exception_gateway.png)](https://travis-ci.org/strikingly/exception_gateway)

A wrapper for error reporting services, currently only bugsnag is supported

## Installation

Add this line to your application's Gemfile:

    gem 'exception_gateway'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exception_gateway

## Usage

1. Configure the backend for error reporting, for example with bugsnag:
    Bugsnag.configure do |config|
      config.release_stage = ENV['RACK_ENV']
      config.api_key = ENV['BUGSNAG_API_KEY']
    end

2. Configure exception_gateway to use the configured backend
    ExceptionGateway.configure do |config|
      config.backend = :bugsnag
    end

3. Use ExceptionGateway to report exception or erros:

    ExceptionGateway.alert("Error!", :msg => "cannot connect to server")
    
    begin
      raise RuntimeError.new("stack overflow")
    rescue Exception => e
      ExceptionGateway.transmit(e)
      raise
    end

    ExceptionGateway.time("roundtrip time") do
      sleep 3
    end
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
