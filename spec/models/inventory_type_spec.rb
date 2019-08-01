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

  describe '#slot' do
    subject { inventory_type.slot }
    let(:inventory_type) { create(:inventory_type, typeName: 'Drone Damage Amplifier II') }
    let(:dogma_effect) { create(:dogma_effect) }
    before(:example) { inventory_type.dogma_type_effects.create dogma_effect: dogma_effect }

    it 'returns `nil` by default' do
      expect(subject).to eq(nil)
    end

    context 'with a loSlot DogmaEffect' do
      let(:dogma_effect) { create(:dogma_effect, effectName: 'loSlot') }

      it 'returns `Low Slot`' do
        expect(subject).to eq('Low Slot')
      end
    end

    context 'with a medPower DogmaEffect' do
      let(:dogma_effect) { create(:dogma_effect, effectName: 'medPower') }

      it 'returns `Mid Slot`' do
        expect(subject).to eq('Mid Slot')
      end
    end

    context 'with a hiPower DogmaEffect' do
      let(:dogma_effect) { create(:dogma_effect, effectName: 'hiPower') }

      it 'returns `High Slot`' do
        expect(subject).to eq('High Slot')
      end
    end

    context 'with a Drone Category' do
      let(:drone_category) { create(:category, categoryName: 'Drone') }
      let(:combat_drone_group) { create(:group, groupName: 'Combat Drone', category: drone_category) }
      let(:inventory_type) { create(:inventory_type, typeName: 'Warrior II', group: combat_drone_group) }


      it 'returns `Drone Bay`' do
        expect(subject).to eq('Drone Bay')
      end
    end
  end
end
