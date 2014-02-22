require 'spec_helper'

module Bugsnag
end

describe ExceptionGateway do
  describe "the module" do
    it "responds to alert" do
      expect(ExceptionGateway).to respond_to(:configure)
    end

    it "responds to configure" do
      expect(ExceptionGateway).to respond_to(:alert)
    end

    it "responds to transmit" do
      expect(ExceptionGateway).to respond_to(:transmit)
    end

    it "responds to time" do
      expect(ExceptionGateway).to respond_to(:time)
    end
  end
  
  describe "configure" do
    before(:all) do
      ExceptionGateway.configure do |config|
        config.backend = :bugsnag
      end
    end
    
    it "hooks call to alert to bugsnag backend" do
      Bugsnag.stub(:notify)
      expect(Bugsnag).to receive(:notify).with(RuntimeError.new("test"), {:details => {:msg => "hello"}})
      ExceptionGateway.alert("test", :msg => "hello")
    end

    it "hooks call to transmit to bugsnag backend" do
      Bugsnag.stub(:notify)
      e = RuntimeError.new("test exception")
      expect(Bugsnag).to receive(:notify).with(e)
      ExceptionGateway.transmit(e)
    end

    it "hooks call to time to bugsnag backend, and reports time" do
      Bugsnag.stub(:notify)
      expect(Bugsnag).to receive(:notify)
      ExceptionGateway.time("test timer") do
        sleep 3
      end
    end
  end
end
