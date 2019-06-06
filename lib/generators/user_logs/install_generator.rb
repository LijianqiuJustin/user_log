require 'rails/generators/base'

module UserLogs
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../templates", __FILE__)

    desc "Creates a UserLogs initializer file to your application."
    class_option :orm

    def initializer
      template "install.rb", "config/initializers/user_logs.rb"
    end
  end
end
