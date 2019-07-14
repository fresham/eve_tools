require 'rails_helper'

RSpec.describe InventoryType, type: :model do
  fixtures :inventory_types
  fixtures :inventory_type_materials

  it 'uses the `invTypes` table' do
    expect(described_class.table_name).to eq('invTypes')
  end

  it 'gives reprocessing yield for Large Rudimentary Concussion Bomb I' do
    inventory_type = inventory_types(:large_rudimentary_concussion_bomb_i)
    reprocessing_yield = inventory_type.reprocessing_yield

    expect(reprocessing_yield).to contain_exactly(
      { inventory_type: inventory_types(:tritanium), quantity: 538 },
      { inventory_type: inventory_types(:pyerite), quantity: 472 },
      { inventory_type: inventory_types(:mexallon), quantity: 435 },
      { inventory_type: inventory_types(:isogen), quantity: 424 },
      { inventory_type: inventory_types(:nocxium), quantity: 505 },
      { inventory_type: inventory_types(:zydrine), quantity: 26 }
    )
  end
end
