require 'ostruct'

module ExceptionGateway
  module Adapters
    class AbstractAdapter
      attr_reader :config

      def initialize(config)
        @config = OpenStruct.new(config)
      end

      def setup_params(msg, options)
        params = { :details => options }
        params[:api_key] = config.api_key if config.api_key

        err = RuntimeError.new(msg)

        [err, params]
      end
    end
  end
end