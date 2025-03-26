# Port of Call

Port of Call is a Ruby gem that assigns each Rails application a consistent, deterministic port number based on the application's name or repository. This solves the common conflict of multiple Rails apps all defaulting to port 3000.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'port_of_call'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install port_of_call
```

After installation, you can generate a configuration initializer:

```bash
$ rails generate port_of_call:install
```

## Usage

### Automatic Port Assignment

Once installed, Port of Call will automatically assign a unique port to your Rails application based on its name. Simply start your server as usual:

```bash
$ rails server
```

You should see output indicating the port that Port of Call has assigned.

### CLI Commands

Port of Call provides a command-line interface for interacting with the gem:

```bash
# Start the Rails server with the calculated port
$ port_of_call server

# Show the calculated port for this application
$ port_of_call port

# Set the calculated port as the default in development.rb
$ port_of_call set

# Show version information
$ port_of_call version

# Display help
$ port_of_call help
```

You can also use the shorter aliases:

```bash
$ port_of_call s    # Same as server
$ port_of_call p    # Same as port
$ port_of_call -v   # Same as version
$ port_of_call -h   # Same as help
```

### Rake Tasks

Port of Call provides several rake tasks:

```bash
# Print the calculated port
$ rake port_of_call

# Start the Rails server with the calculated port
$ rake port_of_call:start

# Generate the initializer
$ rake port_of_call:install

# Set the calculated port as the default
$ rake port_of_call:set_default

# Check if the calculated port is available
$ rake port_of_call:check

# Show configuration information
$ rake port_of_call:info

# Shorthand for port_of_call:start
$ rake poc
```

### Configuration

You can customize Port of Call by editing the initializer at `config/initializers/port_of_call.rb`:

```ruby
PortOfCall.configure do |config|
  # The port range to use (default: 3000..3999)
  config.port_range = 3000..3999
  
  # The base port to start from (default: 3000)
  config.base_port = 3000
  
  # Manually set a project name (default: nil, auto-detected)
  # config.project_name = "my_custom_app_name"
  
  # Reserved ports to avoid (default: [])
  config.reserved_ports = [3333, 4567]
end
```

## How It Works

Port of Call uses a deterministic hashing algorithm to assign ports:

1. It determines your project name through one of these methods (in order):
   - Custom project name from configuration
   - Git repository name
   - Directory name
   - Fallback name ("rails_app")
   
2. It applies a SHA256 hash to the project name and maps it to a port within your configured range.

3. It integrates with Rails so the calculated port is used automatically.

## Troubleshooting

### Port Conflicts

If your calculated port is already in use by another process, Port of Call will display a warning. You have a few options:

1. Stop the other process using that port
2. Configure a different port range to avoid the conflict
3. Use a custom project name to get a different port

### Custom Project Name

If multiple repositories have similar names or you want a specific port, set a custom project name:

```ruby
PortOfCall.configure do |config|
  config.project_name = "my_unique_app_name"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/port_of_call.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).