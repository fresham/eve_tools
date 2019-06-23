class InventoryType < ApplicationRecord
  self.table_name = 'invTypes'

  scope :blueprints, -> { where("typeName LIKE '%Blueprint'") }
end
