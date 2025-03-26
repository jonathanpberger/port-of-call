# frozen_string_literal: true

module PortOfCall
  class Railtie < Rails::Railtie
    # Load rake tasks
    rake_tasks do
      load File.expand_path("../tasks/port_of_call.rake", __dir__)
    end
    
    # Override the server default port
    initializer "port_of_call.set_default_port" do |app|
      # Only override if no port is explicitly specified
      if !ENV["PORT"] && !ENV["RAILS_PORT"]
        port = PortOfCall.calculate_port
        
        # Set the port in the application configuration if available
        if app.config.respond_to?(:server_timing) && app.config.server_timing.respond_to?(:set)
          app.config.server_timing.set(Port: port)
        end
        
        # Hook into Rails command
        if defined?(Rails::Command) && Rails::Command.respond_to?(:invoke)
          Rails::Command.singleton_class.prepend(PortCommandExtension)
        end
        
        # Store the port for other components to use
        ENV["PORT"] = port.to_s
        
        Rails.logger.info "Port of Call: Assigned port #{port} to #{PortOfCall.project_name}" if Rails.logger
      end
    end
    
    # Hook into Rails Server command
    module PortCommandExtension
      def invoke(command_name, *args)
        if command_name == "server" && args.last.is_a?(Hash) && !args.last.key?(:Port)
          args.last[:Port] = PortOfCall.calculate_port
        end
        super
      end
    end
    
    # Generate initializer
    generators do
      require_relative "../generators/port_of_call/install_generator"
    end
  end
end