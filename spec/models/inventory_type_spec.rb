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

  describe '#fitting_slot' do
    subject { inventory_type.fitting_slot }
    let(:inventory_type) { create(:inventory_type, typeName: 'Drone Damage Amplifier II') }
    let(:dogma_effect) { create(:dogma_effect) }
    before(:example) { inventory_type.dogma_type_effects.create dogma_effect: dogma_effect }

    it 'returns `nil` by default' do
      expect(subject).to eq(nil)
    end

    context 'with a loPower DogmaEffect' do
      let(:dogma_effect) { create(:dogma_effect, effectName: 'loPower') }

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

  describe 'fitting attribute methods' do
    let(:inventory_type) { create(:inventory_type) }

    before(:example) do
      inventory_type.dogma_type_attributes.create dogma_attribute: dogma_attribute, valueFloat: 3.0
    end

    describe '#low_slots' do
      subject { inventory_type.low_slots }

      context 'without a `lowSlots` DogmaTypeAttribute' do
        let(:dogma_attribute) { nil }

        it 'returns 0' do
            expect(subject).to eq(0)
        end
      end

      context 'with a `lowSlots` DogmaTypeAttribute value' do
        let(:dogma_attribute) { create(:dogma_attribute, attributeName: 'lowSlots') }

        it 'returns the value as an integer' do
          expect(subject).to eq(3)
        end
      end
    end

    describe '#mid_slots' do
      subject { inventory_type.mid_slots }

      context 'without a `medSlots` DogmaTypeAttribute' do
        let(:dogma_attribute) { nil }

        it 'returns 0' do
            expect(subject).to eq(0)
        end
      end

      context 'with a `medSlots` DogmaTypeAttribute value' do
        let(:dogma_attribute) { create(:dogma_attribute, attributeName: 'medSlots') }

        it 'returns the value as an integer' do
          expect(subject).to eq(3)
        end
      end
    end

    describe '#high_slots' do
      subject { inventory_type.high_slots }

      context 'without a `hiSlots` DogmaTypeAttribute' do
        let(:dogma_attribute) { nil }

        it 'returns 0' do
            expect(subject).to eq(0)
        end
      end

      context 'with a `hiSlots` DogmaTypeAttribute value' do
        let(:dogma_attribute) { create(:dogma_attribute, attributeName: 'hiSlots') }

        it 'returns the value as an integer' do
          expect(subject).to eq(3)
        end
      end
    end

    describe '#rig_slots' do
      subject { inventory_type.rig_slots }

      context 'without a `rigSlots` DogmaTypeAttribute' do
        let(:dogma_attribute) { nil }

        it 'returns 0' do
            expect(subject).to eq(0)
        end
      end

      context 'with a `rigSlots` DogmaTypeAttribute value' do
        let(:dogma_attribute) { create(:dogma_attribute, attributeName: 'rigSlots') }

        it 'returns the value as an integer' do
          expect(subject).to eq(3)
        end
      end
    end
  end
end
