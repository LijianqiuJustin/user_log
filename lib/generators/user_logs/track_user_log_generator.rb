require 'generators/user_logs/helpers'
require 'rails/generators/base'

module UserLogs
  class TrackUserLogGenerator < Rails::Generators::Base
    include UserLogs::Helpers
    source_root File.expand_path("../../templates", __FILE__)

    desc "Creates to be tracked user logs in user_logs.rb under initializers folder"

    def initializer
      UserLogs.track_users.each do |track_user|
        if user = Devise.mappings[track_user]
          user_log_class_name = ""
          if UserLogs.same_path_with_devise
            user_log_class_name = user.class_name.try(:gsub, "::", "/")
          else
            user_log_class_name = user.singular.to_s.camelize.try(:gsub, "::", "/")
          end
          Rails::Generators.invoke("user_logs:migration", ["#{user_log_class_name}Log"])
        end
      end
    end
  end
end
