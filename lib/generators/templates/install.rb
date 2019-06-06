UserLogs.setup do |config|
  # set devise users to be tracked
  config.track_users = [:user]
  # set controllers to be tracked
  config.track_controllers = %w{ActionController::API ApplicationController}
  # record controller params
  config.has_controller_params = true
  # record action params
  config.has_action_params = true
  # set true if want _log.rb same with devise model directory
  config.same_path_with_devise = false
  # send notification use gem 'exception_notification'
  config.send_notification = false
end