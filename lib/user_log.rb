# frozen_string_literal: true

require 'user_log/engine'

module UserLogs
  # autoload :ParameterFilter,    '/user_log/parameter_filter'

  module Controllers
    autoload :Helpers, 'user_log/controllers/helpers'
  end

  mattr_accessor :track_users
  @@track_users = [:user]
  mattr_accessor :track_controllers
  @@track_controllers = %w[ActionController ApplicationController]
  mattr_accessor :has_controller_params
  @@has_controller_params = true
  mattr_accessor :has_action_params
  @@has_action_params = true
  mattr_accessor :use_sidekiq
  @@use_sidekiq = false
  mattr_accessor :log_model
  @@log_model = 'UserLog'
  mattr_accessor :send_notification
  @@send_notification = true
  mattr_accessor :has_browser_uuid
  @@has_browser_uuid = false
  mattr_accessor :log_nil_user
  @@log_nil_user = false

  def self.setup
    yield self
  end
end
