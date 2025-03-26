# frozen_string_literal: true

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
      PortCalculator.new(configuration).calculate
    end
  end
end