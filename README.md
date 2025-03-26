# Port of Call

A Ruby gem that assigns each Rails application a consistent, deterministic port number based on the application's name or repository. This solves the common conflict of multiple Rails apps all defaulting to port 3000.

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

## Usage

### Automatic Port Assignment

Once installed, Port of Call will automatically assign a unique port to your Rails application based on its name. Simply start your server as usual:

```bash
$ rails server
```

### CLI Commands

Print the calculated port for your application:

```bash
$ rake port_of_call
```

Start the Rails server with the calculated port once:

```bash
$ bin/port_of_call
```

### Configuration

You can customize Port of Call by creating an initializer:

```ruby
# config/initializers/port_of_call.rb
PortOfCall.configure do |config|
  config.port_range = 3000..3999  # Default port range
  config.base_port = 3000         # Starting port number
  # Additional configuration options
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/port_of_call.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).