require 'test_helper'

class InventoryTypeTest < ActiveSupport::TestCase
  test 'should use invTypes table' do
    assert_equal 'invTypes', InventoryType.table_name
  end

  test 'should give reprocessing yield' do
    inventory_type = inventory_types(:large_rudimentary_concussion_bomb_i)
    reprocessing_yield = inventory_type.reprocessing_yield

    assert_equal 6, reprocessing_yield.size

    assert_includes reprocessing_yield,
      { inventory_type: inventory_types(:tritanium), quantity: 538 }

    assert_includes reprocessing_yield,
      { inventory_type: inventory_types(:pyerite), quantity: 472 }

    assert_includes reprocessing_yield,
      { inventory_type: inventory_types(:mexallon), quantity: 435 }

    assert_includes reprocessing_yield,
      { inventory_type: inventory_types(:isogen), quantity: 424 }

    assert_includes reprocessing_yield,
      { inventory_type: inventory_types(:nocxium), quantity: 505 }

    assert_includes reprocessing_yield,
      { inventory_type: inventory_types(:zydrine), quantity: 26 }
  end
end
