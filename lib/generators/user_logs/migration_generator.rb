require 'rails/generators/active_record'
require 'generators/user_logs/helpers'

module UserLogs
  class MigrationGenerator < ActiveRecord::Generators::Base
    include UserLogs::Helpers
    source_root File.expand_path("../../templates", __FILE__)

    desc "Creates UserLogs Model to your application."

    def initializer
      File.exist?(File.join(destination_root, model_path))
      if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
        migration_template "migration_existing.rb", "#{migration_path}/add_log_to_#{table_name}.rb", migration_version: migration_version

        if !(behavior == :invoke && model_exists?)
          template "log_model.rb", model_path
        end
      else
        migration_template "migration.rb", "#{migration_path}/user_log_create_#{table_name}.rb", migration_version: migration_version
        template "log_model.rb", model_path
      end
    end
  end
end
