# frozen_string_literal: true

# This is an example of how to use Port of Call programmatically

require "port_of_call"

# Get the calculated port for the current project
puts "Project name: #{PortOfCall.project_name}"
puts "Calculated port: #{PortOfCall.calculate_port}"

# Check if the port is available
port = PortOfCall.calculate_port
if PortOfCall.port_in_use?(port)
  puts "Port #{port} is already in use by another process"
else
  puts "Port #{port} is available"
end

# Configure Port of Call
PortOfCall.configure do |config|
  # Use a different port range
  config.port_range = 4000..4999
  
  # Set a different base port
  config.base_port = 4000
  
  # Set a custom project name
  config.project_name = "my_custom_project"
  
  # Reserve specific ports
  config.reserved_ports = [4000, 4001, 4002]
end

# Get the new calculated port after configuration
puts "New project name: #{PortOfCall.project_name}"
puts "New calculated port: #{PortOfCall.calculate_port}"

# Get server options hash (useful for Rails server)
options = PortOfCall.server_options
puts "Server options: #{options.inspect}"