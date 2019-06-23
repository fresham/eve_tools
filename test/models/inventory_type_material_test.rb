require 'test_helper'

class InventoryTypeMaterialTest < ActiveSupport::TestCase
  test "should use invTypeMaterials table" do
    assert_equal 'invTypeMaterials', InventoryTypeMaterial.table_name
  end
end
