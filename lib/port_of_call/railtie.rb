# frozen_string_literal: true

module PortOfCall
  class Railtie < Rails::Railtie
    # This is just a skeleton - actual implementation will be in step 3
    rake_tasks do
      load "tasks/port_of_call.rake"
    end
    
    # Will implement proper server port override in step 3
    initializer "port_of_call.set_port" do |app|
      # Placeholder for the actual Rails integration
    end
  end
end