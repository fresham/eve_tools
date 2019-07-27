require 'rails_helper'

RSpec.describe EFT do
  describe '.import_fitting' do
    subject { EFT.import_fitting(fitting_text) }
    let(:fitting_text) { tristan_fitting_text }
    let(:tristan_fitting_text) { file_fixture('eft_fittings/tristan.txt').read }

    let!(:tristan) { create(:inventory_type, typeName: 'Tristan') }

    it 'populates the fitting name' do
      tristan
      expect(subject.name).to eq('Solo Example')
    end

    it 'matches and sets ship type' do
      expect(subject.ship).to eq(tristan)
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
end
