# frozen_string_literal: true

RSpec.describe PortOfCall::CLI do
  subject { described_class.new }
  
  describe "#start" do
    context "when called with no arguments" do
      it "calls start_server" do
        expect(subject).to receive(:start_server).with([])
        subject.start([])
      end
    end
    
    context "when called with 'server'" do
      it "calls start_server" do
        expect(subject).to receive(:start_server).with(["--binding=0.0.0.0"])
        subject.start(["server", "--binding=0.0.0.0"])
      end
    end
    
    context "when called with 'port' or 'p'" do
      it "calls show_port" do
        expect(subject).to receive(:show_port)
        subject.start(["port"])
        
        expect(subject).to receive(:show_port)
        subject.start(["p"])
      end
    end
    
    context "when called with 'set'" do
      it "calls set_default_port" do
        expect(subject).to receive(:set_default_port)
        subject.start(["set"])
      end
    end
    
    context "when called with 'version', '--version', or '-v'" do
      it "calls show_version" do
        expect(subject).to receive(:show_version).exactly(3).times
        subject.start(["version"])
        subject.start(["--version"])
        subject.start(["-v"])
      end
    end
    
    context "when called with 'help', '--help', or '-h'" do
      it "calls show_help" do
        expect(subject).to receive(:show_help).exactly(3).times
        subject.start(["help"])
        subject.start(["--help"])
        subject.start(["-h"])
      end
    end
    
    context "when called with an unknown command" do
      it "shows an error and help" do
        expect(subject).to receive(:puts).with("Unknown command: unknown")
        expect(subject).to receive(:show_help)
        subject.start(["unknown"])
      end
    end
  end
  
  # Since we can't easily test methods that interact with Rails or system commands,
  # we'll skip detailed testing of the private methods for now
end