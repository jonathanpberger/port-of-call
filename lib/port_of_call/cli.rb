# frozen_string_literal: true

module PortOfCall
  class CLI
    def self.start(args)
      new.start(args)
    end
    
    def start(args)
      # Basic CLI functionality - will be expanded in step 4
      puts "Port of Call - Calculated port: #{PortOfCall.calculate_port}"
      puts "This is a placeholder for the actual CLI implementation in step 4"
    end
  end
end