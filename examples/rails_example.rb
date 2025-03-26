# frozen_string_literal: true

# This file demonstrates how to use Port of Call in a Rails application

# In your Gemfile:
# -----------------
# gem 'port_of_call'


# In config/initializers/port_of_call.rb:
# ----------------------------------------
# PortOfCall.configure do |config|
#   # The port range to use (default: 3000..3999)
#   config.port_range = 3000..3999
#   
#   # The base port to start from (default: 3000)
#   config.base_port = 3000
#   
#   # Optional: manually set a project name (default: nil, auto-detected)
#   # config.project_name = "my_custom_app_name"
#   
#   # Optional: ports to avoid (default: [])
#   # config.reserved_ports = [3333, 4567]
# end


# In your terminal:
# -----------------
# Show the calculated port:
# $ rake port_of_call
# 
# Start the server with the calculated port:
# $ rails server
# 
# Or use the CLI:
# $ port_of_call server    # Start the server
# $ port_of_call port      # Show the port
# $ port_of_call set       # Set as default port
# 
# Use the shortcut task:
# $ rake poc               # Start the server


# In your Ruby code:
# ------------------
# # Get the calculated port:
# port = PortOfCall.calculate_port
# 
# # Get the project name:
# name = PortOfCall.project_name
# 
# # Check if the port is available:
# if PortOfCall.port_in_use?(port)
#   puts "Port #{port} is in use"
# end
# 
# # Get server options for Rails:
# options = PortOfCall.server_options  # Returns { Port: calculated_port }