module UserLogs
  module Controllers
    # methods added to Controller.
    # extras params: only_track
    module Helpers
      extend ActiveSupport::Concern

      def enter_log(code = nil, delay = true, user = nil, extras: {})
        @user_log_code = code
        @delay_enter_log = delay
        req_params = process_log_parameters

        if user
          # params has a user
          generate_user_log(user, req_params)
        elsif track_users = extras[:only_track]
          track_users.each do |track_user|
            user = get_trackable_user(track_user)
            generate_user_log(user, req_params)
          end
        else
          # track default users
          UserLogs.track_users.each do |track_user|
            user = get_trackable_user(track_user)
            generate_user_log(user, req_params)
          end
        end
      rescue StandardError => e
        if UserLogs.send_notification
          ExceptionNotifier.notify_exception(e, env: request.env)
        end
      end

      def process_log_parameters
        request_parameters = params.dup
        request_parameters.delete(:controller) unless UserLogs.has_controller_params
        request_parameters.delete(:action) unless UserLogs.has_action_params
        req_params = 'none'

        if request_parameters.inspect == '{}'
          req_params = 'none'
        else
          Devise.mappings.each do |mapping|
            params_key = ActiveModel::Naming.param_key(mapping.last.class_name.constantize)
            if request_parameters.key?(params_key)
              request_parameters[params_key].delete('password')
              request_parameters[params_key].delete('password_confirmation')
            end
            request_parameters.delete('password')
            request_parameters.delete('password_confirmation')
            req_params = request_parameters.inspect
            # req_params = request_parameters.as_json
          end
        end

        return req_params
      end

      def get_trackable_user(track_user)
        trackable_user = Devise.mappings[track_user]
        return nil if trackable_user.blank?

        if self.try("#{track_user.to_s}_signed_in?") || instance_variable_defined?("@#{track_user.to_s}")
          return self.try("current_#{track_user.to_s}") || instance_variable_get("@#{track_user.to_s}")
        else
          return nil
        end
      end

      def generate_user_log(user, req_params)
        return if user.blank?
        
        response_body = if @save_response
          JSON.parse(response.body).inspect rescue nil
        else
          nil
        end
        
        attributes = {
          ip:             request.remote_ip,
          user_id:        user.try(:id),
          country:        user.try(:country),
          method:         request.method,
          url:            request.fullpath[0..254],
          response:       (@user_log_code || response.code),
          agent:          request.env['HTTP_USER_AGENT'].try(:[], (0..254)),
          params:         req_params,
          response_body:  response_body,
          created_at:     Time.now
        }      
        if Rails.env.production? && @delay_enter_log
          # TODO
          # UserLogWorker.perform_async(attributes)
        else
          get_user_log_classname(user).constantize.create!(attributes)
        end
      end

      def get_user_log_classname(user)
        if UserLogs.same_path_with_devise
          "#{user.class.name}Log"
        else
          "#{Devise.mappings.map{|m| m.first if m.last.class_name == user.class.name}.reject(&:blank?).first.to_s.camelize}Log"
        end
      end

      def save_response
        @save_response = true
      end
    end
  end
end