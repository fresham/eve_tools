require 'rails_helper'

RSpec.describe InventoryTypeMaterial, type: :model do
  it 'uses invTypeMaterials table' do
    expect(described_class.table_name).to eq('invTypeMaterials')
  end
end
