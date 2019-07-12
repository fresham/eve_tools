require 'rails_helper'

RSpec.describe InventoryTypeMaterial, type: :model do
  it 'uses invTypeMaterials table' do
    assert_equal 'invTypeMaterials', InventoryTypeMaterial.table_name
  end
end
