require 'rails_helper'

RSpec.describe InventoryTypeReaction, type: :model do
  it 'uses invTypeReactions table' do
    assert_equal 'invTypeReactions', InventoryTypeReaction.table_name
  end
end
