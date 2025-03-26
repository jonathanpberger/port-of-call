# frozen_string_literal: true

require_relative "lib/port_of_call/version"

Gem::Specification.new do |spec|
  spec.name = "port_of_call"
  spec.version = PortOfCall::VERSION
  spec.authors = ["JPB"]
  spec.email = ["jonathanpberger@gmail.com"]

  spec.summary = "Deterministic port assignment for Rails applications"
  spec.description = "Port of Call assigns each Rails application a consistent, deterministic port number based on the application's name or repository. This solves the common conflict of multiple Rails apps all defaulting to port 3000."
  spec.homepage = "https://github.com/jpb/port-of-claude"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["documentation_uri"] = "#{spec.homepage}/blob/main/README.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "rails", ">= 6.0"
  
  # Development dependencies
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "rubocop", "~> 1.21"
end