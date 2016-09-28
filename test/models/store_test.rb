require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  test "association" do
  	first_store = Store.first
    assert first_store.purchase_orders.count == 1
    assert first_store.user.present?
  end
end
