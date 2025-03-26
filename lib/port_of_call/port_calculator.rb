# frozen_string_literal: true

module PortOfCall
  class PortCalculator
    attr_reader :config
    
    def initialize(config)
      @config = config
    end
    
    def calculate
      # This is just a placeholder - actual implementation will be in step 2
      # Will extract project name and create a deterministic port number
      project_name = extract_project_name
      hash_value = hash_project_name(project_name)
      port_from_hash(hash_value)
    end
    
    private
    
    def extract_project_name
      # Will implement in step 2
      # Extract from Rails.root or git repository
      "sample_project"
    end
    
    def hash_project_name(name)
      # Will implement in step 2
      # Create a deterministic hash from the project name
      name.hash.abs
    end
    
    def port_from_hash(hash_value)
      # Will implement in step 2
      # Map the hash to a port within the configured range
      range_size = config.port_range.size
      offset = hash_value % range_size
      config.base_port + offset
    end
  end
end