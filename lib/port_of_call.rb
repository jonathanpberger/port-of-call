# frozen_string_literal: true

require "socket"
require_relative "port_of_call/version"
require_relative "port_of_call/configuration"
require_relative "port_of_call/port_calculator"
require_relative "port_of_call/railtie" if defined?(Rails)
require_relative "port_of_call/cli"

module PortOfCall
  class Error < StandardError; end
  
  class << self
    attr_writer :configuration
    
    def configuration
      @configuration ||= Configuration.new
    end
    
    def configure
      yield(configuration)
    end
    
    def reset
      @configuration = Configuration.new
    end
    
    def calculate_port
      calculator.calculate
    end
    
    def project_name
      calculator.send(:extract_project_name)
    end
    
    def available?
      port = calculate_port
      !port_in_use?(port)
    end
    
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
    
    def server_options
      { Port: calculate_port }
    end
    
    private
    
    def calculator
      @calculator ||= PortCalculator.new(configuration)
    end
  end
end