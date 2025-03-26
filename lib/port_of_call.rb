# frozen_string_literal: true

require "socket"
require_relative "port_of_call/version"
require_relative "port_of_call/configuration"
require_relative "port_of_call/port_calculator"
require_relative "port_of_call/cli"

# Only require Rails-specific code if Rails is defined
if defined?(Rails) && Rails.respond_to?(:application)
  require_relative "port_of_call/railtie"
end

# Port of Call is a Ruby gem that assigns each Rails application a consistent,
# deterministic port number based on the application's name or repository.
# This solves the common conflict of multiple Rails apps all defaulting to port 3000.
#
# @example Basic usage with Rails
#   # In Gemfile
#   gem 'port_of_call'
#   
#   # Your Rails server will automatically use a unique port
#   # based on your project name
#   
# @example Configuration via initializer
#   # In config/initializers/port_of_call.rb
#   PortOfCall.configure do |config|
#     config.port_range = 3000..3999
#     config.base_port = 3000
#     # config.project_name = "custom_name" # Optional
#   end
#
# @example Ruby API usage
#   require 'port_of_call'
#   
#   # Get the calculated port for the current project
#   port = PortOfCall.calculate_port
#   
#   # Check if the port is available
#   if PortOfCall.port_in_use?(port)
#     puts "Port #{port} is already in use!"
#   end
module PortOfCall
  # Standard error class for Port of Call exceptions
  class Error < StandardError; end
  
  class << self
    attr_writer :configuration
    
    # Returns the current configuration
    # @return [Configuration] the current configuration
    def configuration
      @configuration ||= Configuration.new
    end
    
    # Configures the gem with the given block
    # @yield [config] The configuration object
    # @example
    #   PortOfCall.configure do |config|
    #     config.port_range = 4000..4999
    #     config.base_port = 4000
    #   end
    def configure
      yield(configuration)
    end
    
    # Resets the configuration to defaults
    # @return [Configuration] the new configuration object
    def reset
      @configuration = Configuration.new
    end
    
    # Calculates the port for the current project
    # @return [Integer] the calculated port number
    def calculate_port
      calculator.calculate
    end
    
    # Returns the detected or configured project name
    # @return [String] the project name
    def project_name
      calculator.send(:extract_project_name)
    end
    
    # Checks if the calculated port is available
    # @return [Boolean] true if the port is available, false if in use
    def available?
      port = calculate_port
      !port_in_use?(port)
    end
    
    # Checks if a specific port is in use by another process
    # @param port [Integer] the port to check
    # @return [Boolean] true if the port is in use, false if available
    def port_in_use?(port)
      # Check if the port is already in use by another process
      begin
        socket = TCPServer.new('127.0.0.1', port)
        socket.close
        false
      rescue Errno::EADDRINUSE
        true
      end
    end
    
    # Returns options hash for Rails server
    # @return [Hash] options with the Port key set
    def server_options
      { Port: calculate_port }
    end
    
    private
    
    # Returns the port calculator instance
    # @return [PortCalculator] the port calculator
    def calculator
      @calculator ||= PortCalculator.new(configuration)
    end
  end
end