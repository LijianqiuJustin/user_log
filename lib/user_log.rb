require "user_log/engine"

module UserLogs
  autoload :ParameterFilter,    '/user_log/parameter_filter'

  module Controllers
    autoload :Helpers,        'user_log/controllers/helpers'
  end

  mattr_accessor :track_users
  @@track_users = [:user]
  mattr_accessor :track_controllers
  @@track_controllers = ["ActionController", "ApplicationController"]
  mattr_accessor :has_controller_params
  @@has_controller_params = true
  mattr_accessor :has_action_params
  @@has_action_params = true
  mattr_accessor :use_sidekiq
  @@use_sidekiq = false
  mattr_accessor :same_path_with_devise
  @@same_path_with_devise = false
  mattr_accessor :send_notification
  @@send_notification = false


  def self.setup
    yield self
  end
end
