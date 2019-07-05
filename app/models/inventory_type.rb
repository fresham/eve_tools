class InventoryType < ApplicationRecord
  self.table_name = 'invTypes'

  has_many :inventory_type_materials, foreign_key: :typeID
  has_many :inventory_type_reactions, foreign_key: :typeID
  has_many :materials, through: :inventory_type_materials, source: :inventory_type
  has_many :reactions, through: :inventory_type_reactions, source: :inventory_type

  def reprocessing_yield(efficiency = 0.50)
    inventory_type_materials.map do |inventory_type_material|
      {
        inventory_type: inventory_type_material.inventory_type,
        quantity: (inventory_type_material.quantity * efficiency).to_i,
      }
    end
  end
end
