module ExceptionGateway
  module Adapters
    class BugsnagAdapter < AbstractAdapter
      def alert(msg, options = {})
        Bugsnag.notify(*setup_params(msg, options))
      end

      def transmit(exception)
        Bugsnag.notify(exception)
      end
    end
  end
end
