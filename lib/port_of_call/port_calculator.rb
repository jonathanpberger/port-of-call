# frozen_string_literal: true

require "digest"

module PortOfCall
  class PortCalculator
    attr_reader :config
    
    def initialize(config)
      @config = config
    end
    
    def calculate
      project_name = extract_project_name
      hash_value = hash_project_name(project_name)
      port_from_hash(hash_value)
    end
    
    private
    
    def extract_project_name
      # Use custom project name if set
      return config.project_name if config.project_name
      
      # Try multiple methods to determine the project name
      git_name || directory_name || fallback_name
    end
    
    def git_name
      return nil unless File.exist?(File.join(root_path, '.git'))
      
      # Try to get name from git remote origin URL
      remote_url = `cd #{root_path} && git config --get remote.origin.url 2>/dev/null`.strip
      return extract_git_repo_name(remote_url) unless remote_url.empty?
      
      # Fallback to git directory name
      nil
    end
    
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
    
    def directory_name
      # Use base name of the root directory
      File.basename(root_path)
    end
    
    def fallback_name
      # Fallback name in case all else fails
      "rails_app"
    end
    
    def hash_project_name(name)
      # Use SHA256 for consistent hashing across platforms
      # Take the first 8 hex chars (32 bits) and convert to integer
      Digest::SHA256.hexdigest(name)[0, 8].to_i(16)
    end
    
    def port_from_hash(hash_value)
      # Get the size of the port range
      range_size = config.port_range.size
      
      # Calculate offset based on hash value
      offset = hash_value % range_size
      
      # Apply offset to base port
      config.base_port + offset
    end
    
    def root_path
      if defined?(Rails) && Rails.respond_to?(:root)
        Rails.root.to_s
      else
        Dir.pwd
      end
    end
  end
end