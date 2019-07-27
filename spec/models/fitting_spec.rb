require 'rails_helper'

RSpec.describe Fitting, type: :model do
  subject { build(:fitting) }

  context 'without an associated ship' do
    subject { build(:fitting, ship: nil) }

    it 'is invalid' do
      expect(subject).to be_invalid
    end
  end
end
