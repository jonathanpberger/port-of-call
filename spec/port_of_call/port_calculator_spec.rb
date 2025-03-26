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
    
    context "with a custom project name" do
      before do
        config.project_name = "custom_project_name"
      end
      
      it "uses the custom project name for port calculation" do
        expect(subject).to receive(:extract_project_name).and_return("custom_project_name")
        subject.calculate
      end
    end
  end
  
  describe "private methods" do
    describe "#extract_project_name" do
      it "tries to get name from git, directory, or fallback" do
        expect(subject).to receive(:git_name).and_return(nil)
        expect(subject).to receive(:directory_name).and_return("test_dir")
        expect(subject.send(:extract_project_name)).to eq("test_dir")
      end
      
      context "when custom project name is set" do
        before do
          config.project_name = "custom_name"
          allow(subject).to receive(:git_name).and_return(nil)
          allow(subject).to receive(:directory_name).and_return("test_dir")
        end
        
        it "uses the custom name" do
          expect(subject.send(:extract_project_name)).to eq("custom_name")
        end
      end
    end
    
    describe "#hash_project_name" do
      it "produces a consistent hash for the same input" do
        hash1 = subject.send(:hash_project_name, "test_project")
        hash2 = subject.send(:hash_project_name, "test_project")
        expect(hash1).to eq(hash2)
      end
      
      it "produces different hashes for different inputs" do
        hash1 = subject.send(:hash_project_name, "project_a")
        hash2 = subject.send(:hash_project_name, "project_b")
        expect(hash1).not_to eq(hash2)
      end
    end
    
    describe "#port_from_hash" do
      it "returns a port within the configured range" do
        # Test with various hash values
        [0, 100, 1000, 1_000_000].each do |hash|
          port = subject.send(:port_from_hash, hash)
          expect(port).to be_between(config.port_range.min, config.port_range.max)
        end
      end
      
      it "distributes ports evenly within the range" do
        # This is a statistical test, might occasionally fail
        ports = (1..1000).map { |i| subject.send(:port_from_hash, i) }
        
        # Count occurrences of each port
        counts = ports.group_by { |p| p }.transform_values(&:count)
        
        # Check that distribution is somewhat even (within 20%)
        mean = counts.values.sum.to_f / counts.keys.count
        max_deviation = mean * 0.2
        
        counts.each do |port, count|
          expect(count).to be_within(max_deviation).of(mean)
        end
      end
    end
  end
end