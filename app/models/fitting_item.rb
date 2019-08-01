class FittingItem < ApplicationRecord
  belongs_to :inventory_type
  belongs_to :fitting

  scope :low_slots, -> { where(slot: 'Low Slot') }
  scope :mid_slots, -> { where(slot: 'Mid Slot') }
  scope :high_slots, -> { where(slot: 'High Slot') }
  scope :rig_slots, -> { where(slot: 'Rig Slot') }
  scope :drones, -> { where(slot: 'Drone Bay') }
  scope :cargo, -> { where(slot: 'Cargo Bay') }
end
