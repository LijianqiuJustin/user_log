# frozen_string_literal: true

require 'test_helper'

class UserLogs::Test < ActiveSupport::TestCase
  test 'user_log' do
    assert_kind_of Module, UserLogs
  end
end
