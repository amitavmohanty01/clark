require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user count" do
    assert User.count == 2
  end
end
