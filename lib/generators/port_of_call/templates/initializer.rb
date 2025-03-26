# frozen_string_literal: true

# Port of Call Configuration
#
# This initializer configures the Port of Call gem, which automatically
# assigns a unique, deterministic port to your Rails application.
#
# For more information, see: https://github.com/jpb/port-of-claude

PortOfCall.configure do |config|
  # The port range to use (default: 3000..3999)
  # config.port_range = 3000..3999
  
  # The base port to start from (default: 3000)
  # config.base_port = 3000
  
  # Manually set a project name (default: nil, auto-detected)
  # config.project_name = "my_custom_app_name"
  
  # Reserved ports to avoid (default: [])
  # config.reserved_ports = [3333, 4567]
end