module ExceptionGateway
  module Vendors
    def bugsnag_alert(msg, options={})
      Bugsnag.notify(RuntimeError.new(msg), {:details => options})
    end

    def bugsnag_transmit(exception)
      Bugsnag.notify(exception)
    end
  end
end
