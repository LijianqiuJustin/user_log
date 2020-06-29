# frozen_string_literal: true

UserLogs.setup do |config|
  config.log_model = '<%= log_model %>'
  # set devise users to be tracked
  config.track_users = [:user]
  # set controllers to be tracked
  config.track_controllers = %w[ActionController::API ApplicationController]
  # record controller params
  config.has_controller_params = false
  # record action params
  config.has_action_params = false
  # set uuid
  config.has_browser_uuid = false
  # log only current devise user exists
  config.log_nil_user = false
end
