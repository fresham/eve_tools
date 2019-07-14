require 'rails_helper'

RSpec.describe InventoryTypeReaction, type: :model do
  it 'uses invTypeReactions table' do
    expect(described_class.table_name).to eq('invTypeReactions')
  end
end
