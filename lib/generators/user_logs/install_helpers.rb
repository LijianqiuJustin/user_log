# frozen_string_literal: true

module UserLogs
  module Generators
    module InstallHelpers
      def model_exists?
        File.exist?(File.join(destination_root, model_path))
      end

      def migration_exists?(table_name)
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_add_log_to_#{table_name}.rb$/).first
      end

      def migration_path
        if Rails.version >= '5.0.3' && Rails.version <= '5.1.7'
          db_migrate_path
        else
          @migration_path ||= File.join('db', 'migrate')
        end
      end

      def model_path
        @model_path ||= File.join('app', 'models', "#{file_path}.rb")
      end

      def rails5?
        Rails.version.start_with? '5'
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]" if rails5?
      end

      def file_array
        paths = class_path.dup
        paths << file_name
        paths
      end

      def log_model
        file_array.map(&:camelize).join('::')
      end
    end
  end
end
