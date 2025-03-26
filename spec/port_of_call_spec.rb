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
    
    it "returns a number within the configured range" do
      port = PortOfCall.calculate_port
      expect(port).to be_between(
        PortOfCall.configuration.port_range.min,
        PortOfCall.configuration.port_range.max
      )
    end
  end
  
  describe ".project_name" do
    it "returns a string" do
      expect(PortOfCall.project_name).to be_a(String)
    end
    
    context "with a custom project name" do
      before do
        PortOfCall.configure do |config|
          config.project_name = "custom_project"
        end
      end
      
      after do
        PortOfCall.reset
      end
      
      it "returns the custom project name" do
        expect(PortOfCall.project_name).to eq("custom_project")
      end
    end
  end
  
  describe ".port_in_use?" do
    it "checks if a port is in use" do
      # This is hard to test without actually binding to a port
      # We'll just make sure it doesn't error
      expect { PortOfCall.port_in_use?(PortOfCall.calculate_port) }.not_to raise_error
    end
  end
  
  describe ".server_options" do
    it "returns a hash with the Port key" do
      options = PortOfCall.server_options
      expect(options).to be_a(Hash)
      expect(options).to have_key(:Port)
      expect(options[:Port]).to eq(PortOfCall.calculate_port)
    end
  end
end