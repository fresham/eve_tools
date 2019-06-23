class InventoryTypeMaterial < ApplicationRecord
  self.table_name = 'invTypeMaterials'

  belongs_to :inventory_type, foreign_key: :materialTypeID
end
