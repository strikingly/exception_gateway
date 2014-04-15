module ExceptionGateway
  module Vendors
    def bugsnag_alert(msg, options={})
      if ExceptionGateway.config.bugsnag_alert_api_key
        Bugsnag.notify(RuntimeError.new(msg), {:details => options})
      else
        Bugsnag.notify(RuntimeError.new(msg), {:details => options}, api_key: ExceptionGateway.config.bugsnag_alert_api_key)
      end
    end

    def bugsnag_transmit(exception)
      Bugsnag.notify(exception)
    end
  end
end
