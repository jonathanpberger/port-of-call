# Port of Call 0.1.0 Release Notes

We're excited to announce the initial release of Port of Call!

Port of Call is a Ruby gem that assigns each Rails application a consistent, deterministic port number based on the application's name or repository. This solves the common conflict of multiple Rails apps all defaulting to port 3000.

## Features

### Automatic Port Assignment
- Simply install the gem, and your Rails server will use a unique port based on your project name
- No configuration required - it just works!

### Deterministic Ports
- Same project always gets the same port on any machine
- Consistent development experience across your team

### Multiple Interface Options
- Command-line interface with intuitive commands
- Rake tasks for easy integration
- Ruby API for programmatic use

### Customization
- Configurable port range
- Custom project name option
- Reserved ports list

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'port_of_call'
```

And then execute:

```bash
$ bundle install
$ rails generate port_of_call:install  # Optional
```

## Usage

Start your Rails server as usual:

```bash
$ rails server
```

You should see output indicating the port that Port of Call has assigned.

## Documentation

For detailed usage instructions, see the [README](README.md).

## Feedback

We welcome feedback, bug reports, and feature requests! Please submit issues on GitHub.

---

Thank you for using Port of Call!