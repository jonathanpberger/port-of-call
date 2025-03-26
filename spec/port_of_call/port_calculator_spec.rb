# frozen_string_literal: true

RSpec.describe PortOfCall::PortCalculator do
  let(:config) { PortOfCall::Configuration.new }
  subject { described_class.new(config) }

  describe "#calculate" do
    it "returns a port number within the configured range" do
      port = subject.calculate
      expect(port).to be_between(config.port_range.min, config.port_range.max)
    end
    
    it "returns the same port when called multiple times" do
      first_port = subject.calculate
      second_port = subject.calculate
      expect(first_port).to eq(second_port)
    end
  end
end