# frozen_string_literal: true

require 'test_helper'
require 'generators/user_logs/install_generator'

class InstallGeneratorTest < ::Rails::Generators::TestCase
  tests UserLogs::Generators::InstallGenerator
  destination File.expand_path("../../tmp", File.dirname(__FILE__))
  arguments %w(UserLog)
  setup :prepare_destination

  test "creates file" do
    run_generator

    assert_file "config/initializers/user_logs.rb"

    assert_file "app/workers/user_logs_worker.rb"

    assert_file "app/models/user_log.rb"
  end
end
