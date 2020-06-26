require 'rails/generators/active_record'
require 'generators/user_logs/install_helpers'

module UserLogs
  module Generators
    class InstallGenerator < ActiveRecord::Generators::Base
      include Rails::Generators::Migration
      include UserLogs::Generators::InstallHelpers

      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a UserLogs initializer file to your application."
      class_option :orm

      def initializer
        template "install.rb", "config/initializers/user_logs.rb"
        template "log_worker.rb", "app/workers/#{table_name}_worker.rb"

        File.exist?(File.join(destination_root, model_path))

        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
          migration_template "migration_existing.rb", "#{migration_path}/add_log_to_#{table_name}.rb", migration_version: migration_version

          if !(behavior == :invoke && model_exists?)
            template "log_model.rb", model_path
          end
        else
          migration_template "migration.rb", "#{migration_path}/_create_#{table_name}.rb", migration_version: migration_version
          template "log_model.rb", model_path
        end
      end
    end
  end
end
