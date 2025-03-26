# frozen_string_literal: true

namespace :port_of_call do
  desc "Print the calculated port for this Rails application"
  task :port => :environment do
    port = PortOfCall.calculate_port
    project_name = PortOfCall.project_name
    puts "Port of Call - Calculated port for #{project_name}: #{port}"
    
    # Check if the port is already in use
    if PortOfCall.port_in_use?(port)
      puts "WARNING: Port #{port} is already in use by another process!"
    end
  end
  
  desc "Start the Rails server with the calculated port"
  task :start => :environment do
    port = PortOfCall.calculate_port
    project_name = PortOfCall.project_name
    
    puts "Port of Call - Starting Rails server for #{project_name} on port #{port}"
    
    # Check if the port is already in use
    if PortOfCall.port_in_use?(port)
      puts "WARNING: Port #{port} is already in use by another process!"
      exit 1
    end
    
    # Start the Rails server with the calculated port
    system("rails", "server", "-p", port.to_s)
  end
  
  desc "Generate an initializer for Port of Call"
  task :install => :environment do
    puts "Generating Port of Call initializer..."
    system("rails", "generate", "port_of_call:install")
  end
  
  desc "Set the calculated port as the default for this Rails application"
  task :set_default => :environment do
    port = PortOfCall.calculate_port
    project_name = PortOfCall.project_name
    
    # Get Rails development.rb config file
    config_file = Rails.root.join("config", "environments", "development.rb")
    
    if File.exist?(config_file)
      content = File.read(config_file)
      
      if content.include?("config.port = ")
        # Update existing port setting
        updated_content = content.gsub(/config\.port\s*=\s*\d+/, "config.port = #{port}")
      else
        # Add new port setting at the end of the config block
        updated_content = content.gsub(/(Rails\.application\.configure do.*?)(\nend)/m, "\\1\n  # Port of Call - Assigned port\n  config.port = #{port}\n\\2")
      end
      
      # Write updated content back to the file
      File.write(config_file, updated_content)
      
      puts "Port of Call - Set default port for #{project_name} to #{port} in #{config_file}"
    else
      puts "ERROR: Could not find development.rb config file"
      exit 1
    end
  end
  
  desc "Check if the calculated port is available"
  task :check => :environment do
    port = PortOfCall.calculate_port
    project_name = PortOfCall.project_name
    
    puts "Port of Call - Checking port #{port} for #{project_name}..."
    
    if PortOfCall.port_in_use?(port)
      puts "WARNING: Port #{port} is already in use by another process!"
      exit 1
    else
      puts "Port #{port} is available."
    end
  end
  
  desc "Show configuration information for Port of Call"
  task :info => :environment do
    port = PortOfCall.calculate_port
    project_name = PortOfCall.project_name
    config = PortOfCall.configuration
    
    puts "Port of Call - Configuration Information"
    puts "---------------------------------------"
    puts "Project name:     #{project_name}"
    puts "Calculated port:  #{port}"
    puts "Port range:       #{config.port_range}"
    puts "Base port:        #{config.base_port}"
    puts "Custom name:      #{config.custom_project_name || 'Not set'}"
    puts "Reserved ports:   #{config.reserved_ports.empty? ? 'None' : config.reserved_ports.join(', ')}"
    puts "---------------------------------------"
    
    if PortOfCall.port_in_use?(port)
      puts "WARNING: Port #{port} is already in use by another process!"
    else
      puts "Port #{port} is available."
    end
  end
end

# Add shortcut tasks at the top level
desc "Print the calculated port for this Rails application"
task :port_of_call => "port_of_call:port"

desc "Start the Rails server with the calculated port"
task :poc => "port_of_call:start"