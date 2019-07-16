require 'rails_helper'

RSpec.describe InventoryType, type: :model do
  it 'uses the `invTypes` table' do
    expect(described_class.table_name).to eq('invTypes')
  end

  describe '#reprocessing_yield' do
    let(:reprocessing_efficiency) { 0.50 }

    let(:inventory_type) { create(:inventory_type, typeName: 'Large Rudimentary Concussion Bomb I') }
    let(:tritanium) { create(:inventory_type, typeName: 'Tritanium') }
    let(:pyerite) { create(:inventory_type, typeName: 'Pyerite') }
    let(:mexallon) { create(:inventory_type, typeName: 'Mexallon') }
    let(:isogen) { create(:inventory_type, typeName: 'Isogen') }
    let(:nocxium) { create(:inventory_type, typeName: 'Nocxium') }
    let(:zydrine) { create(:inventory_type, typeName: 'Zydrine') }

    before do
      create(:inventory_type_material, input: tritanium, quantity: 1076, output: inventory_type)
      create(:inventory_type_material, input: pyerite, quantity: 945, output: inventory_type)
      create(:inventory_type_material, input: mexallon, quantity: 871, output: inventory_type)
      create(:inventory_type_material, input: isogen, quantity: 848, output: inventory_type)
      create(:inventory_type_material, input: nocxium, quantity: 1010, output: inventory_type)
      create(:inventory_type_material, input: zydrine, quantity: 52, output: inventory_type)
    end

    subject { inventory_type.reprocessing_yield(reprocessing_efficiency) }

    it 'gives accurate reprocessing yield for Large Rudimentary Concussion Bomb I' do
      expect(subject).to contain_exactly(
        { inventory_type: tritanium, quantity: 538 },
        { inventory_type: pyerite, quantity: 472 },
        { inventory_type: mexallon, quantity: 435 },
        { inventory_type: isogen, quantity: 424 },
        { inventory_type: nocxium, quantity: 505 },
        { inventory_type: zydrine, quantity: 26 }
      )
    end
  end
end
