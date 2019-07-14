class InventoryTypeMaterial < ApplicationRecord
  self.table_name = 'invTypeMaterials'

  belongs_to :output, foreign_key: :typeID, class_name: :InventoryType
  belongs_to :input, foreign_key: :materialTypeID, class_name: :InventoryType
end
