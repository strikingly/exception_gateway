module ExceptionGateway
  module Adapters
    class ConsoleAdapter < AbstractAdapter
      def alert(msg, options = {})
        puts "ExceptionGateway.alert: #{msg}"
      end

      def transmit(exception)
        puts "ExceptionGateway.transmit: #{exception.message}"
      end
    end
  end
end
