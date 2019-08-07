class InventoryType < ApplicationRecord
  self.table_name = 'invTypes'

  belongs_to :group, foreign_key: :groupID

  has_many :inventory_type_materials, foreign_key: :typeID
  has_many :inventory_type_products, foreign_key: :materialTypeID, class_name: :InventoryTypeMaterial
  has_many :materials, through: :inventory_type_materials, source: :input
  has_many :products, through: :inventory_type_products, source: :output

  has_many :inventory_type_reactions, foreign_key: :typeID
  has_many :reactions, through: :inventory_type_reactions, source: :inventory_type

  has_many :dogma_type_effects, foreign_key: :typeID
  has_many :dogma_effects, through: :dogma_type_effects

  has_many :dogma_type_attributes, foreign_key: :typeID
  has_many :dogma_attributes, through: :dogma_type_attributes

  delegate :category, to: :group

  def reprocessing_yield(efficiency = 0.50)
    inventory_type_materials.map do |inventory_type_material|
      {
        inventory_type: inventory_type_material.input,
        quantity: (inventory_type_material.quantity * efficiency).to_i,
      }
    end
  end

  def fitting_slot
    slot_map = {
      'loPower' => 'Low Slot',
      'medPower' => 'Mid Slot',
      'hiPower' => 'High Slot',
      'rigSlot' => 'Rig Slot',
    }

    slot_effect = dogma_effects.find_by(effectName: slot_map.keys)

    if slot_effect
      slot_map[slot_effect&.effectName]
    elsif category.categoryName == 'Drone'
      'Drone Bay'
    end
  end

  def low_slots
    dogma_type_attribute = find_dogma_type_attribute_by_name('lowSlots')
    return 0 if dogma_type_attribute.blank?
    (dogma_type_attribute.valueFloat || dogma_type_attribute.valueInt).to_i
  end

  def mid_slots
    dogma_type_attribute = find_dogma_type_attribute_by_name('medSlots')
    return 0 if dogma_type_attribute.blank?
    (dogma_type_attribute.valueFloat || dogma_type_attribute.valueInt).to_i
  end

  def high_slots
    dogma_type_attribute = find_dogma_type_attribute_by_name('hiSlots')
    return 0 if dogma_type_attribute.blank?
    (dogma_type_attribute.valueFloat || dogma_type_attribute.valueInt).to_i
  end

  def rig_slots
    dogma_type_attribute = find_dogma_type_attribute_by_name('rigSlots')
    return 0 if dogma_type_attribute.blank?
    (dogma_type_attribute.valueFloat || dogma_type_attribute.valueInt).to_i
  end

  private

  def find_dogma_type_attribute_by_name(name)
    dogma_type_attributes.includes(:dogma_attribute).find_by(dgmAttributeTypes: { attributeName: name })

  end
end
