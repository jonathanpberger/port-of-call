# frozen_string_literal: true

require "digest"

module PortOfCall
  # Calculates deterministic port numbers based on project name
  #
  # This class is responsible for:
  # 1. Extracting the project name from various sources
  # 2. Hashing the project name consistently
  # 3. Mapping the hash to a port number within the configured range
  class PortCalculator
    # @return [Configuration] the configuration instance
    attr_reader :config
    
    # Initialize a new calculator with the given configuration
    # @param config [Configuration] the configuration instance
    def initialize(config)
      @config = config
    end
    
    # Calculate a deterministic port number for the current project
    # @return [Integer] the calculated port number
    def calculate
      project_name = extract_project_name
      hash_value = hash_project_name(project_name)
      port_from_hash(hash_value)
    end
    
    private
    
    # Extract the project name using various methods
    # @return [String] the project name
    def extract_project_name
      # Use custom project name if set
      return config.project_name if config.project_name
      
      # Try multiple methods to determine the project name
      git_name || directory_name || fallback_name
    end
    
    # Try to get the project name from git
    # @return [String, nil] the project name from git, or nil if not available
    def git_name
      return nil unless File.exist?(File.join(root_path, '.git'))
      
      # Try to get name from git remote origin URL
      remote_url = `cd #{root_path} && git config --get remote.origin.url 2>/dev/null`.strip
      return extract_git_repo_name(remote_url) unless remote_url.empty?
      
      # Fallback to git directory name
      nil
    end
    
    # Extract repository name from git URL
    # @param url [String] the git remote URL
    # @return [String, nil] the repository name, or nil if not parseable
    def extract_git_repo_name(url)
      return nil if url.nil? || url.empty?
      
      # Match various git URL formats:
      # - https://github.com/user/repo.git
      # - git@github.com:user/repo.git
      # - git://github.com/user/repo
      if url =~ %r{/([^/]+?)(\.git)?$} || url =~ %r{:([^/]+?)(\.git)?$}
        return $1
      end
      
      nil
    end
    
    # Get the project name from the directory name
    # @return [String] the directory name
    def directory_name
      # Use base name of the root directory
      File.basename(root_path)
    end
    
    # Fallback project name to use if all else fails
    # @return [String] the fallback name
    def fallback_name
      # Fallback name in case all else fails
      "rails_app"
    end
    
    # Hash the project name to an integer consistently
    # @param name [String] the project name
    # @return [Integer] a hash value
    def hash_project_name(name)
      # Use SHA256 for consistent hashing across platforms
      # Take the first 8 hex chars (32 bits) and convert to integer
      Digest::SHA256.hexdigest(name)[0, 8].to_i(16)
    end
    
    # Map a hash value to a port number within the configured range
    # @param hash_value [Integer] the hash value
    # @return [Integer] a port number
    def port_from_hash(hash_value)
      # Get the size of the port range
      range_size = config.port_range.size
      
      # Calculate offset based on hash value
      offset = hash_value % range_size
      
      # Apply offset to base port
      config.base_port + offset
    end
    
    # Get the root path of the application
    # @return [String] the root path
    def root_path
      if defined?(Rails) && Rails.respond_to?(:root)
        Rails.root.to_s
      else
        Dir.pwd
      end
    end
  end
end