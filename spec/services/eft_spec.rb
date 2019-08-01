require 'rails_helper'

RSpec.shared_examples 'fitting attributes' do
  it 'populates the fitting name' do
    expect(subject.name).to eq(fitting_name)
  end

  it 'matches and sets ship type' do
    expect(subject.ship).to eq(tristan)
  end

  it 'sets low slots for the fit' do
    subject.save
    expect(subject.fitting_items.find_by(inventory_type: dcu, slot: 'Low Slot').quantity).to eq(1)
    expect(subject.fitting_items.find_by(inventory_type: dda, slot: 'Low Slot').quantity).to eq(1)
    expect(subject.fitting_items.find_by(inventory_type: saar, slot: 'Low Slot').quantity).to eq(1)
  end

  it 'sets mid slots for the fit' do
    subject.save
    expect(subject.fitting_items.find_by(inventory_type: ab, slot: 'Mid Slot').quantity).to eq(1)
    expect(subject.fitting_items.find_by(inventory_type: scram, slot: 'Mid Slot').quantity).to eq(1)
    expect(subject.fitting_items.find_by(inventory_type: web, slot: 'Mid Slot').quantity).to eq(1)
  end

  it 'sets high slots for the fit' do
    subject.save
    expect(subject.fitting_items.find_by(inventory_type: blaster, slot: 'High Slot').quantity).to eq(2)
    expect(subject.fitting_items.find_by(inventory_type: neut, slot: 'High Slot').quantity).to eq(1)
  end

  it 'sets rig slots for the fit' do
    subject.save
    expect(subject.fitting_items.find_by(inventory_type: anti_explosive_pump, slot: 'Rig Slot').quantity).to eq(1)
    expect(subject.fitting_items.find_by(inventory_type: transverse_bulkhead, slot: 'Rig Slot').quantity).to eq(2)
  end

  it 'sets drone bay for the fit' do
    subject.save
    expect(subject.fitting_items.find_by(inventory_type: warrior, slot: 'Drone Bay').quantity).to eq(5)
  end

  it 'sets cargo bay for the fit' do
    subject.save
    expect(subject.fitting_items.find_by(inventory_type: null, slot: 'Cargo Bay').quantity).to eq(1600)
    expect(subject.fitting_items.find_by(inventory_type: void, slot: 'Cargo Bay').quantity).to eq(1600)
    expect(subject.fitting_items.find_by(inventory_type: nanite, slot: 'Cargo Bay').quantity).to eq(50)
  end

  context 'with a bad header' do
    let(:fitting_text) { "[BAD HEADER]\n" + tristan_fitting_text }

    it 'throws an error' do
      expect { subject }.to raise_error(RuntimeError, 'Invalid EFT header')
    end
  end

  context 'with a ship not matchable in database' do
    let(:fitting_text) { "[UNKNOWN, BAD FIT]\n" + tristan_fitting_text }

    it 'throws an error' do
      expect { subject }.to raise_error(RuntimeError, 'Unknown ship type: `UNKNOWN`')
    end
  end
end

RSpec.describe EFT do
  describe '.import_fitting' do
    subject { EFT.import_fitting(fitting_text) }

    let(:fitting_text) { tristan_fitting_text }
    let(:tristan_fitting_text) { file_fixture('eft_fittings/tristan.txt').read }
    let(:fitting_name) { 'Solo Example' }

    let!(:tristan) { create(:inventory_type, typeName: 'Tristan') }
    let!(:dcu) { create(:inventory_type, typeName: 'Damage Control II') }
    let!(:dda) { create(:inventory_type, typeName: 'Drone Damage Amplifier II') }
    let!(:saar) { create(:inventory_type, typeName: 'Small Ancillary Armor Repairer') }
    let!(:ab) { create(:inventory_type, typeName: '1MN Afterburner II')  }
    let!(:web) { create(:inventory_type, typeName: 'Fleeting Compact Stasis Webifier')  }
    let!(:scram) { create(:inventory_type, typeName: 'Initiated Compact Warp Scrambler')  }
    let!(:blaster) { create(:inventory_type, typeName: 'Light Neutron Blaster II')  }
    let!(:neut) { create(:inventory_type, typeName: 'Small Gremlin Compact Energy Neutralizer')  }
    let!(:anti_explosive_pump) { create(:inventory_type, typeName: 'Small Anti-Explosive Pump I')  }
    let!(:transverse_bulkhead) { create(:inventory_type, typeName: 'Small Transverse Bulkhead I')  }

    let(:drone_category) { create(:category, categoryName: 'Drone') }
    let(:combat_drone_group) { create(:group, groupName: 'Combat Drone', category: drone_category) }

    let!(:warrior) { create(:inventory_type, typeName: 'Warrior II', group: combat_drone_group) }
    let!(:null) { create(:inventory_type, typeName: 'Null S') }
    let!(:void) { create(:inventory_type, typeName: 'Void S') }
    let!(:nanite) { create(:inventory_type, typeName: 'Nanite Repair Paste') }

    let(:low_slot_effect) { create(:dogma_effect, effectName: 'loSlot') }
    let(:mid_slot_effect) { create(:dogma_effect, effectName: 'medPower') }
    let(:high_slot_effect) { create(:dogma_effect, effectName: 'hiPower') }
    let(:rig_slot_effect) { create(:dogma_effect, effectName: 'rigSlot') }

    before(:example) do
      dcu.dogma_type_effects.create(dogma_effect: low_slot_effect)
      dda.dogma_type_effects.create(dogma_effect: low_slot_effect)
      saar.dogma_type_effects.create(dogma_effect: low_slot_effect)

      ab.dogma_type_effects.create(dogma_effect: mid_slot_effect)
      web.dogma_type_effects.create(dogma_effect: mid_slot_effect)
      scram.dogma_type_effects.create(dogma_effect: mid_slot_effect)

      blaster.dogma_type_effects.create(dogma_effect: high_slot_effect)
      neut.dogma_type_effects.create(dogma_effect: high_slot_effect)

      anti_explosive_pump.dogma_type_effects.create(dogma_effect: rig_slot_effect)
      transverse_bulkhead.dogma_type_effects.create(dogma_effect: rig_slot_effect)
    end

    context 'with a normal fitting' do
      include_examples 'fitting attributes'
    end

    context 'with a fitting from Windows copy/paste with carriage returns' do
      let(:fitting_text) { file_fixture('eft_fittings/tristan_windows.txt').read }
      let(:fitting_name) { 'Windows Example' }
      include_examples 'fitting attributes'
    end
  end
end
