# frozen_string_literal: true

module PortOfCall
  # Configuration class for Port of Call settings
  #
  # @attr [Range] port_range The range of port numbers to use
  # @attr [Integer] base_port The base port number
  # @attr [String, nil] custom_project_name Optional custom project name to override auto-detection
  # @attr [Array<Integer>] reserved_ports List of ports to avoid using
  class Configuration
    attr_accessor :port_range, :base_port, :custom_project_name, :reserved_ports
    
    # Initialize a new configuration with default values
    def initialize
      @port_range = 3000..3999
      @base_port = 3000
      @custom_project_name = nil
      @reserved_ports = []
    end
    
    # Get the custom project name
    # @return [String, nil] the custom project name or nil if not set
    def project_name
      @custom_project_name
    end
    
    # Set a custom project name
    # @param name [String] the project name to use
    def project_name=(name)
      @custom_project_name = name
    end
    
    # Calculate the size of the port range
    # @return [Integer] the number of ports in the range
    def port_range_size
      @port_range.end - @port_range.begin + 1
    end
    
    # Check if a port is available within the configuration constraints
    # @param port [Integer] the port to check
    # @return [Boolean] true if the port is in range and not reserved
    def available_port?(port)
      port_range.include?(port) && !reserved_ports.include?(port)
    end
  end
end