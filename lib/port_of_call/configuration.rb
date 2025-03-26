# frozen_string_literal: true

module PortOfCall
  class Configuration
    attr_accessor :port_range, :base_port
    
    def initialize
      @port_range = 3000..3999
      @base_port = 3000
    end
  end
end