# frozen_string_literal: true

module PortOfCall
  # Command Line Interface for Port of Call
  #
  # Provides command-line functionality for interacting with Port of Call.
  # Available commands:
  # - server: Start Rails server with calculated port
  # - port: Show the calculated port
  # - set: Set port as default in development.rb
  # - version: Show version information
  # - help: Display usage information
  class CLI
    # Start the CLI with the given arguments
    # @param args [Array<String>] command-line arguments
    # @return [void]
    def self.start(args)
      new.start(args)
    end
    
    # Route to the appropriate command
    # @param args [Array<String>] command-line arguments
    # @return [void]
    def start(args)
      command = args.shift || "server"
      
      case command
      when "server", "s"
        start_server(args)
      when "port", "p"
        show_port
      when "set"
        set_default_port
      when "version", "--version", "-v"
        show_version
      when "help", "--help", "-h"
        show_help
      else
        puts "Unknown command: #{command}"
        show_help
      end
    end
    
    private
    
    # Start the Rails server with the calculated port
    # @param args [Array<String>] additional arguments for the server
    # @return [void]
    def start_server(args)
      # Get the calculated port
      port = PortOfCall.calculate_port
      project_name = PortOfCall.project_name
      
      # Check if the port is already in use
      if PortOfCall.port_in_use?(port)
        puts "WARNING: Port #{port} is already in use by another process!"
        exit 1
      end
      
      # Construct server command
      if defined?(Rails) && defined?(Rails::Server)
        puts "Port of Call - Starting Rails server for #{project_name} on port #{port}"
        
        # Add -p option if not already specified
        unless args.include?("-p") || args.include?("--port")
          args.unshift("-p", port.to_s)
        end
        
        # Start server
        Rails::Server.new(args).tap do |server|
          # Set port in server options
          server.options[:Port] = port if server.options[:Port].nil?
          
          # Start server
          server.start
        end
      else
        # Fallback when not running in a Rails context
        puts "Port of Call - Rails environment not detected"
        puts "Calculated port for #{project_name}: #{port}"
      end
    end
    
    # Show the calculated port
    # @return [void]
    def show_port
      port = PortOfCall.calculate_port
      project_name = PortOfCall.project_name
      
      puts "Port of Call - Calculated port for #{project_name}: #{port}"
      
      # Check if the port is already in use
      if PortOfCall.port_in_use?(port)
        puts "WARNING: Port #{port} is already in use by another process!"
      end
    end
    
    # Set the calculated port as the default in development.rb
    # @return [void]
    def set_default_port
      if defined?(Rails) && defined?(Rails.root)
        # Use rake task for this
        system("rake", "port_of_call:set_default")
      else
        puts "ERROR: Rails environment not detected"
        exit 1
      end
    end
    
    # Show version information
    # @return [void]
    def show_version
      puts "Port of Call v#{PortOfCall::VERSION}"
    end
    
    # Show help information
    # @return [void]
    def show_help
      puts <<~HELP
        Port of Call v#{PortOfCall::VERSION} - Deterministic port assignment for Rails applications
        
        Usage: port_of_call [COMMAND] [OPTIONS]
        
        Commands:
          server, s       Start the Rails server with the calculated port (default)
          port, p         Show the calculated port for this application
          set             Set the calculated port as the default in development.rb
          version, -v     Display version information
          help, -h        Show this help message
        
        Examples:
          port_of_call            # Start the Rails server with the calculated port
          port_of_call port       # Show the calculated port
          port_of_call set        # Set the calculated port as the default
      HELP
    end
  end
end