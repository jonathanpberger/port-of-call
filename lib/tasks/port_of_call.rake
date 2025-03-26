# frozen_string_literal: true

namespace :port_of_call do
  desc "Print the calculated port for this Rails application"
  task :port => :environment do
    puts "Port of Call - Calculated port for this application: #{PortOfCall.calculate_port}"
  end
  
  desc "Start the Rails server with the calculated port"
  task :start => :environment do
    # This is a placeholder - actual implementation will be in step 4
    port = PortOfCall.calculate_port
    puts "Starting Rails server on port #{port}"
    # Will actually start the server in step 4
  end
end

# Add a shortcut task at the top level
desc "Print the calculated port for this Rails application"
task :port_of_call => "port_of_call:port"