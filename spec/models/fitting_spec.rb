require 'rails_helper'

RSpec.describe Fitting, type: :model do
  subject { create(:fitting, ship: tristan) }
  let!(:tristan) { create(:inventory_type, typeName: 'Tristan') }
  let!(:damage_control) { create(:inventory_type, typeName: 'Damage Control II') }
  let!(:afterburner) { create(:inventory_type, typeName: 'Damage Control II') }

  describe '#low_slots' do
    it 'returns all low slot FittingItems' do
      fitting_item = subject.fitting_items.create(inventory_type: damage_control, slot: 'Low Slot')
      expect(subject.low_slots.to_a).to eq([fitting_item])
    end
  end

  describe '#mid_slots' do
    it 'returns all mid slot FittingItems' do
      fitting_item = subject.fitting_items.create(inventory_type: afterburner, slot: 'Mid Slot')
      expect(subject.mid_slots.to_a).to eq([fitting_item])
    end
  end

  describe '#high_slots' do
    it 'returns all high slot FittingItems' do
      fitting_item = subject.fitting_items.create(inventory_type: afterburner, slot: 'Mid Slot')
      expect(subject.mid_slots.to_a).to eq([fitting_item])
    end
  end

  context 'without an associated ship' do
    subject { build(:fitting, ship: nil) }

    it 'is invalid' do
      expect(subject).to be_invalid
    end
  end
end
