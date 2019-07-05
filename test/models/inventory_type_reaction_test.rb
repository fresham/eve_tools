require 'test_helper'

class InventoryTypeReactionTest < ActiveSupport::TestCase
  test "should use invTypeReactions table" do
    assert_equal 'invTypeReactions', InventoryTypeReaction.table_name
  end
end
