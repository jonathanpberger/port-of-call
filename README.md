⛵️ Why use Port of Call?
=============================
Do you have multiple Rails apps running on your machine? Tired of conflicts on port 3000? I was, so I vibe-coded this gem.

Port of Call automatically assigns deterministic port numbers to each Rails application based on its name.

⛵️⛵️ Who's Port of Call for?
=============================
Rails developers who tend to work on multiple applications simultaneously

⛵️⛵️⛵️ What exactly does Port of Call do?
=============================
Port of Call deterministically assigns port numbers to Rails applications:

1. It extracts your application's name from Git or directory name
2. It creates a hash of the name using SHA256
3. It maps this hash to a port number within your configured range (default: 3000-3999)
4. It automatically sets this port when you start your Rails server

The same app always gets the same port on any machine, avoiding conflicts!

⛵️⛵️⛵️⛵️ How do I use it?
=============================
1. Install the gem:
   ```ruby
   # In your Gemfile
   gem 'port_of_call'
   ```

2. Bundle install:
   ```bash
   $ bundle install
   ```

3. Generate the initializer (optional):
   ```bash
   $ rails generate port_of_call:install
   ```

4. Run your server as usual:
   ```bash
   $ rails server
   ```

CLI Commands:
- `port_of_call server` - Start Rails server with calculated port
- `port_of_call port` - Show the calculated port
- `port_of_call set` - Set as default port in development.rb
- `port_of_call -v` - Show version information
- `port_of_call -h` - Show help

Rake Tasks:
- `rake port_of_call` - Show calculated port
- `rake port_of_call:start` - Start Rails server
- `rake poc` - Shorthand for starting the server

⛵️⛵️⛵️⛵️⛵️ Extras
=============================
Configuration:
```ruby
# In config/initializers/port_of_call.rb
PortOfCall.configure do |config|
  # Change port range (default: 3000..3999)
  config.port_range = 4000..4999
  
  # Set custom project name
  config.project_name = "my_unique_app_name"
  
  # Avoid specific ports
  config.reserved_ports = [4567, 5000]
end
```

Troubleshooting:
- If your port is already in use, Port of Call will warn you
- To check port availability: `rake port_of_call:check`
- For detailed info: `rake port_of_call:info`

GitHub: [github.com/jonathanpberger/port-of-call](https://github.com/jonathanpberger/port-of-call)

License: MIT with additional [disclaimer](LICENSE.txt)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt.