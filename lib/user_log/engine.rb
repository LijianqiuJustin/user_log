require "user_log/version"

module UserLogs
  class Engine < ::Rails::Engine
    isolate_namespace UserLogs

    initializer "user_log.track_controllers", after: :load_config_initializers, before: :build_middleware_stack do |app|
      UserLogs.track_controllers.each do |controller_name|
        controller_name.constantize.include UserLogs::Controllers::Helpers
      end
    end
  end
end