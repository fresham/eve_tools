require 'rails_helper'

RSpec.xdescribe FittingProcessor do
  describe '.populate_fitting_data' do
    let(:tristan) { create(:inventory_type, typeName: 'Tristan') }
    let(:drone_damage_amplifier) { create(:inventory_type, typeName: 'Drone Damage Amplifier II') }
    let(:overdrive_injector_system) { create(:inventory_type, typeName: 'Overdrive Injector System II') }
    let(:micro_auxiliary_power_core) { create(:inventory_type, typeName: 'Micro Auxiliary Power Core I') }
    let(:microwarpdrive) { create(:inventory_type, typeName: '5MN Y-T8 Compact Microwarpdrive') }
    let(:adaptive_invulnerability_field) { create(:inventory_type, typeName: 'Adaptive Invulnerability Field II') }
    let(:medium_shield_extender) { create(:inventory_type, typeName: 'Medium Shield Extender II') }
    let(:entosis_link) { create(:inventory_type, typeName: 'Entosis Link I') }
    let(:gatling_rail) { create(:inventory_type, typeName: '75mm Gatling Rail II') }
    let(:small_core_defense_field_extender) { create(:inventory_type, typeName: 'Small Core Defense Field Extender I') }
    let(:small_polycarbon_engine_housing) { create(:inventory_type, typeName: 'Small Polycarbon Engine Housing I') }
    let(:hornet_ec300) { create(:inventory_type, typeName: 'Hornet EC-300') }
    let(:warrior) { create(:inventory_type, typeName: 'Warrior II') }
    let(:implant) { create(:inventory_type, typeName: "Eifyr and Co. 'Rogue' Navigation NN-601") }
    let(:frentix_booster) { create(:inventory_type, typeName: 'Standard Frentix Booster') }
    let(:lead_charge_s) { create(:inventory_type, typeName: 'Caldari Navy Lead Charge S') }
    let(:strontium_clathrates) { create(:inventory_type, typeName: 'Strontium Clathrates') }

    let(:fitting) { create(:fitting) }
    let(:fitting_text) { file_fixture('eft_fittings/tristan.txt').read }
    subject { FittingProcessor.populate_fitting_data(fitting, fitting_text) }

    it 'populates the name field' do
      subject
      expect(fitting.name).to eq('Full Fit')
    end

    it 'populates FittingItems' do
      expect(FittingItem).to receive(:create).with(fitting: fitting, inventory_type: tristan, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: drone_damage_amplifier, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: overdrive_injector_system, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: micro_auxiliary_power_core, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: microwarpdrive, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: adaptive_invulnerability_field, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: medium_shield_extender, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: entosis_link, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: gatling_rail, quantity: 2)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: small_core_defense_field_extender, quantity: 2)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: small_polycarbon_engine_housing, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: hornet_ec300, quantity: 3)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: warrior, quantity: 5)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: implant, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: frentix_booster, quantity: 1)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: lead_charge_s, quantity: 400)

      expect(FittingItem).to receive(:create)
          .with(fitting: fitting, inventory_type: strontium_clathrates, quantity: 35)

      subject
    end
  end
end
