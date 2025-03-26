# Port of Call

## Next Steps

Port of Call has been installed and configured. Your Rails server will now
automatically use a unique, deterministic port based on your project name.

### Usage

To start your Rails server with the calculated port:

```bash
$ rails server
```

To see the calculated port:

```bash
$ rake port_of_call
```

### Configuration

Your configuration file is at `config/initializers/port_of_call.rb`. 
You can edit this file to customize the behavior of Port of Call.

For more information, see: https://github.com/jpb/port-of-claude