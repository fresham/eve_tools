class InventoryType < ApplicationRecord
  self.table_name = 'invTypes'

  has_many :inventory_type_materials, foreign_key: :typeID
  has_many :materials, through: :inventory_type_materials, source: :inventory_type

  scope :blueprints, -> { where("typeName LIKE '%Blueprint'") }
end
