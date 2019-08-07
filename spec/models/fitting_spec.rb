require 'rails_helper'

RSpec.describe Fitting, type: :model do
  subject { tristan_fitting }
  let!(:tristan) { create(:inventory_type, typeName: 'Tristan') }
  let!(:tristan_fitting) { create(:fitting, ship: tristan, name: 'Unfit') }
  let!(:damage_control) { create(:inventory_type, typeName: 'Damage Control II') }
  let!(:afterburner) { create(:inventory_type, typeName: 'Damage Control II') }

  before(:example) do
    allow(tristan).to receive(:low_slots).and_return(3)
    allow(tristan).to receive(:mid_slots).and_return(3)
    allow(tristan).to receive(:high_slots).and_return(3)
    allow(tristan).to receive(:rig_slots).and_return(3)
  end

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

  describe '#eft_block' do
    subject { tristan_fitting.eft_block }

    context 'with an empty fit' do
      let(:unfit_tristan_text) { file_fixture('eft_fittings/tristan_unfit.txt').read }

      it 'returns an eft_block in original order by default' do
        expect(subject).to eq(unfit_tristan_text.strip)
      end
    end

    context 'with a regular full fit' do
      let!(:tristan_fitting) { create(:fitting, ship: tristan, name: 'Solo Example') }
      let(:tristan_text) { file_fixture('eft_fittings/tristan.txt').read }

      before(:example) do
        tristan_fitting.fitting_items.create([
          { inventory_type: create(:inventory_type, typeName: 'Damage Control II'), slot: 'Low Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Drone Damage Amplifier II'), slot: 'Low Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Small Ancillary Armor Repairer'), slot: 'Low Slot' },
          { inventory_type: create(:inventory_type, typeName: '1MN Afterburner II'), slot: 'Mid Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Fleeting Compact Stasis Webifier'), slot: 'Mid Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Initiated Compact Warp Scrambler'), slot: 'Mid Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Light Neutron Blaster II'), slot: 'High Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Small Gremlin Compact Energy Neutralizer'),
            slot: 'High Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Light Neutron Blaster II'), slot: 'High Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Small Anti-Explosive Pump I'), slot: 'Rig Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Small Transverse Bulkhead I'), slot: 'Rig Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Small Transverse Bulkhead I'), slot: 'Rig Slot' },
          { inventory_type: create(:inventory_type, typeName: 'Warrior II'), slot: 'Drone Bay', quantity: 5 },
          { inventory_type: create(:inventory_type, typeName: 'Null S'), slot: 'Cargo Bay', quantity: 1600 },
          { inventory_type: create(:inventory_type, typeName: 'Void S'), slot: 'Cargo Bay', quantity: 1600 },
          { inventory_type: create(:inventory_type, typeName: 'Nanite Repair Paste'), slot: 'Cargo Bay', quantity: 50 },
        ])
      end

      it 'returns an eft_block in original order by default' do
        expect(subject).to eq(tristan_text.strip)
      end

      context 'with `sorted` option' do
        subject { tristan_fitting.eft_block(sorted: true) }
        let!(:tristan_fitting) { create(:fitting, ship: tristan, name: 'Sorted') }
        let(:sorted_tristan_text) { file_fixture('eft_fittings/tristan_sorted.txt').read }

        xit 'returns an eft_block with sorting' do
          expect(subject).to eq(sorted_tristan_text.strip)
        end
      end
    end
  end

  context 'without an associated ship' do
    subject { build(:fitting, ship: nil) }

    it 'is invalid' do
      expect(subject).to be_invalid
    end
  end
end
