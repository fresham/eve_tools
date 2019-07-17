require 'rails_helper'
require 'parsers/eft_parser'

RSpec.describe Parsers::EftParser do
  describe '.parse' do
    subject { described_class.parse(fitting_text) }

    context 'when given a full, valid fitting' do
      let(:fitting_text) { file_fixture('eft_fittings/tristan.txt').read }

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
end
