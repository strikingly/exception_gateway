module ExceptionGateway
  module Adapters
    class BugsnagAdapter < AbstractAdapter
      def alert(msg, options = {})
        params = { :details => options }
        params[:api_key] = options[:api_key] if options[:api_key] # never used
        error = msg.kind_of?(StandardError) ? msg : RuntimeError.new(msg)

        Bugsnag.notify(error, params)
      end

      def transmit(exception)
        Bugsnag.notify(exception)
      end
    end
  end
end
