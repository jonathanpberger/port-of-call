# frozen_string_literal: true

module PortOfCall
  class Configuration
    attr_accessor :port_range, :base_port, :custom_project_name, :reserved_ports
    
    def initialize
      @port_range = 3000..3999
      @base_port = 3000
      @custom_project_name = nil
      @reserved_ports = []
    end
    
    def project_name
      @custom_project_name
    end
    
    def project_name=(name)
      @custom_project_name = name
    end
    
    def port_range_size
      @port_range.end - @port_range.begin + 1
    end
    
    def available_port?(port)
      port_range.include?(port) && !reserved_ports.include?(port)
    end
  end
end