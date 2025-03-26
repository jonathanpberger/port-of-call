# frozen_string_literal: true

require "rails/generators"

module PortOfCall
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)
      
      desc "Creates a Port of Call initializer for your application"
      
      def copy_initializer
        template "initializer.rb", "config/initializers/port_of_call.rb"
      end
      
      def show_readme
        readme "README.md" if behavior == :invoke
      end
    end
  end
end