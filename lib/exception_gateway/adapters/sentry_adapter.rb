module ExceptionGateway
  module Adapters
    class SentryAdapter < AbstractAdapter
      def alert(msg, options = {})
        Raven.capture_exception(*setup_params(msg, options))
      end

      def transmit(exception)
        Raven.capture_exception(exception)
      end
    end
  end
end
