# frozen_string_literal: true

RSpec.describe PortOfCall do
  it "has a version number" do
    expect(PortOfCall::VERSION).not_to be nil
  end

  describe ".configuration" do
    it "returns a Configuration instance" do
      expect(PortOfCall.configuration).to be_a(PortOfCall::Configuration)
    end
  end

  describe ".configure" do
    after do
      PortOfCall.reset
    end

    it "allows configuration through a block" do
      PortOfCall.configure do |config|
        config.port_range = 4000..4999
        config.base_port = 4000
      end

      expect(PortOfCall.configuration.port_range).to eq(4000..4999)
      expect(PortOfCall.configuration.base_port).to eq(4000)
    end
  end

  describe ".calculate_port" do
    it "returns a number" do
      expect(PortOfCall.calculate_port).to be_a(Integer)
    end
  end
end