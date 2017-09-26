require 'ostruct'

module ExceptionGateway
  module Adapters
    class AbstractAdapter
      attr_reader :config

      def initialize(config)
        @config = OpenStruct.new(config)
      end

      private

      def setup_params(msg, options)
        params = { :details => options }
        params[:api_key] = config.alert_api_key if config.alert_api_key

        err = msg.kind_of?(StandardError) ? msg : StandardError.new(msg)

        [err, params]
      end
    end
  end
end