# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0.alpha1] - 2025-03-25

### Added
- Initial pre-release of Port of Call gem
- Core port calculation functionality
  - Project name extraction from git or directory
  - Deterministic SHA256 hashing algorithm
  - Configurable port range mapping
- Rails integration via Railtie
  - Automatic port assignment for Rails server
  - Generator for configuration initializer
- Command-line interface
  - Server command for starting Rails
  - Port command for displaying calculated port
  - Set command for setting default port
  - Version and help commands
- Rake tasks for common operations
  - port_of_call:port to show calculated port
  - port_of_call:start to start server
  - port_of_call:install to generate initializer
  - port_of_call:set_default to update development.rb
  - port_of_call:check to verify port availability
  - port_of_call:info to display configuration
- Configuration options
  - Custom port range
  - Base port setting
  - Project name override
  - Reserved ports list