require 'test_helper'

class InventoryTypeTest < ActiveSupport::TestCase
  test "should use invTypes table" do
    assert_equal 'invTypes', InventoryType.table_name
  end
end
