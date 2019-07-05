class InventoryTypeReaction < ApplicationRecord
  self.table_name = 'invTypeReactions'

  belongs_to :inventory_type, foreign_key: :reactionTypeID
end
