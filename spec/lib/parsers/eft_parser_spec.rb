require 'rails_helper'
require 'parsers/eft_parser'

RSpec.describe Parsers::EftParser do
  let(:fitting_text) { file_fixture('eft_fittings/tristan.txt').read }

  describe '.parse' do
    subject { described_class.parse(fitting_text) }

    context 'when given a full, valid fitting' do
      it 'returns a list of items in the fit with quantity' do
        expect(subject[:name]).to eq('Full Fit')
        expect(subject[:items]).to include(
          'Tristan' => { quantity: 1, location: :hull },
          'Drone Damage Amplifier II' => 1,
          'Overdrive Injector System II' => 1,
          'Micro Auxiliary Power Core I' => 1,
          '5MN Y-T8 Compact Microwarpdrive' => 1,
          'Adaptive Invulnerability Field II' => 1,
          'Medium Shield Extender II' => 1,
          'Entosis Link I' => 1,
          '75mm Gatling Rail II' => 2,
          'Small Core Defense Field Extender I' => 2,
          'Small Polycarbon Engine Housing I' => 1,
          'Hornet EC-300' => 3,
          'Warrior II' => 5,
          "Eifyr and Co. 'Rogue' Navigation NN-601" => 1,
          'Standard Frentix Booster' => 1,
          'Caldari Navy Lead Charge S' => 400,
          'Strontium Clathrates' => 35
        )
      end

      context 'with carriage return line endings' do
        let(:fitting_text) { file_fixture('eft_fittings/tristan.txt').read.gsub("\n", "\r\n") }

        it 'returns a list of items in the fit with quantity' do
          expect(subject[:name]).to eq('Full Fit')
          expect(subject[:items]).to include(
            'Tristan' => 1,
            'Drone Damage Amplifier II' => 1,
            'Overdrive Injector System II' => 1,
            'Micro Auxiliary Power Core I' => 1,
            '5MN Y-T8 Compact Microwarpdrive' => 1,
            'Adaptive Invulnerability Field II' => 1,
            'Medium Shield Extender II' => 1,
            'Entosis Link I' => 1,
            '75mm Gatling Rail II' => 2,
            'Small Core Defense Field Extender I' => 2,
            'Small Polycarbon Engine Housing I' => 1,
            'Hornet EC-300' => 3,
            'Warrior II' => 5,
            "Eifyr and Co. 'Rogue' Navigation NN-601" => 1,
            'Standard Frentix Booster' => 1,
            'Caldari Navy Lead Charge S' => 400,
            'Strontium Clathrates' => 35
          )
        end
      end
    end

    context 'when given an unfit ship fitting' do
      let(:fitting_text) { file_fixture('eft_fittings/tristan_unfit.txt').read }

      it 'returns only the ship hull in list of items' do
        expect(subject[:name]).to eq('Unfit')
        expect(subject[:items]).to include('Tristan' => 1)
        expect(subject[:items].size).to eq(1)
      end
    end
  end

  describe '.ignore_line?' do
    subject { described_class.ignore_line?(line) }

    context 'given an empty slot line' do
      let(:line) { '[Empty Low Slot]' }

      it 'is ignored' do
        expect(subject).to be(true)
      end
    end

    context 'given an empty line' do
      let(:line) { '' }

      it 'is ignored' do
        expect(subject).to be(true)
      end
    end

    context 'given a line with only spaces' do
      let(:line) { " \t\n" }

      it 'is ignored' do
        expect(subject).to be(true)
      end
    end
  end

  describe '.parse_line' do
    subject { described_class.parse_line(line) }

    context 'given a valid line without line ending' do
      let(:line) { 'Tristan' }

      it 'returns a hash with quantity of 1' do
        expect(subject).to eq({ 'Tristan' => 1 })
      end
    end

    context 'given a valid line without line ending' do
      let(:line) { "Tristan\n" }

      it 'returns a hash with quantity of 1' do
        expect(subject).to eq({ 'Tristan' => 1 })
      end
    end
  end

  describe '.read_sections' do
    subject { described_class.read_sections(fitting_text) }

    it 'returns an array of sections' do
      expect(subject).to contain_exactly(
        [
          module_hash(name: 'Drone Damage Amplifier II'),
          module_hash(name: 'Overdrive Injector System II'),
          module_hash(name: 'Micro Auxiliary Power Core I'),
          module_hash(name: '5MN Y-T8 Compact Microwarpdrive'),
          module_hash(name: 'Adaptive Invulnerability Field II'),
          module_hash(name: 'Medium Shield Extender II'),
          module_hash(name: 'Entosis Link I'),
          module_hash(name: '75mm Gatling Rail II'),
          module_hash(name: '75mm Gatling Rail II'),
          module_hash(name: 'Small Core Defense Field Extender I'),
          module_hash(name: 'Small Core Defense Field Extender I'),
          module_hash(name: 'Small Polycarbon Engine Housing I')
        ],
        [
          drone_cargo_hash(name: 'Hornet EC-300', quantity: 3),
          drone_cargo_hash(name: 'Warrior II', quantity: 5)
        ],
        [
          module_hash(name: "Eifyr and Co. 'Rogue' Navigation NN-601"),
          module_hash(name: 'Standard Frentix Booster')
        ],
        [
          drone_cargo_hash(name: 'Caldari Navy Lead Charge S', quantity: 400),
          drone_cargo_hash(name: 'Strontium Clathrates', quantity: 35)
        ]
      )
    end
  end
end

def module_hash(attributes)
  { name: nil, charge: nil, offline: nil, mutation: nil }.merge(attributes)
end

def drone_cargo_hash(attributes)
  { name: nil, quantity: nil }.merge(attributes)
end
