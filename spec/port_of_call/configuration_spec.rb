# frozen_string_literal: true

RSpec.describe PortOfCall::Configuration do
  subject { described_class.new }

  it "has default configuration values" do
    expect(subject.port_range).to eq(3000..3999)
    expect(subject.base_port).to eq(3000)
    expect(subject.custom_project_name).to be_nil
    expect(subject.reserved_ports).to eq([])
  end

  describe "#project_name=" do
    it "sets the custom project name" do
      subject.project_name = "test_project"
      expect(subject.project_name).to eq("test_project")
      expect(subject.custom_project_name).to eq("test_project")
    end
  end

  describe "#port_range_size" do
    it "returns the size of the port range" do
      expect(subject.port_range_size).to eq(1000)
      
      subject.port_range = 5000..5099
      expect(subject.port_range_size).to eq(100)
    end
  end

  describe "#available_port?" do
    it "returns true for ports in range and not reserved" do
      expect(subject.available_port?(3500)).to be true
    end
    
    it "returns false for ports outside the range" do
      expect(subject.available_port?(2999)).to be false
      expect(subject.available_port?(4000)).to be false
    end
    
    it "returns false for reserved ports" do
      subject.reserved_ports = [3500, 3600]
      expect(subject.available_port?(3500)).to be false
      expect(subject.available_port?(3600)).to be false
      expect(subject.available_port?(3700)).to be true
    end
  end
end