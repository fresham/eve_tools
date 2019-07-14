require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'uses the `invGroups` table' do
    expect(described_class.table_name).to eq('invGroups')
  end
end
