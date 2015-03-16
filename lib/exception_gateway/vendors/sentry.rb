module ExceptionGateway
  module Vendors
    def sentry_alert(msg, options={})
      if ExceptionGateway.config.sentry_alert_api_key
        Raven.capture_exception(RuntimeError.new(msg), {:details => options, :api_key => ExceptionGateway.config.sentry_alert_api_key})
      else
        Raven.capture_exception(RuntimeError.new(msg), {:details => options})
      end
    end

    def sentry_transmit(exception)
      Raven.capture_exception(exception)
    end
  end
end
