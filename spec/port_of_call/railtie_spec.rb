# frozen_string_literal: true

# Skip this test if Rails is not available
unless defined?(Rails)
  RSpec.describe "PortOfCall Rails integration" do
    it "has a file for Railtie integration" do
      railtie_path = File.expand_path("../../lib/port_of_call/railtie.rb", __dir__)
      expect(File.exist?(railtie_path)).to be true
    end
  end
end