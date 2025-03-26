# frozen_string_literal: true

# We'll need to mock Rails for proper testing
# This is just a simplified test for now
RSpec.describe "PortOfCall Rails integration" do
  it "has a Railtie defined when Rails is available" do
    # Temporarily define Rails if not defined
    rails_defined = defined?(Rails)
    
    unless rails_defined
      # Define a minimal Rails module for testing
      module Rails
        class Railtie; end
      end
    end
    
    # Load the main module
    load File.expand_path("../../lib/port_of_call.rb", __dir__)
    
    # Check that Railtie is defined
    expect(defined?(PortOfCall::Railtie)).to eq("constant")
    
    # Clean up if we defined Rails
    unless rails_defined
      Object.send(:remove_const, :Rails)
    end
  end
end