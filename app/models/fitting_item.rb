class FittingItem < ApplicationRecord
  belongs_to :inventory_type
  belongs_to :fitting

  scope :low_slots, -> { where(slot: 'Low Slot') }
  scope :mid_slots, -> { where(slot: 'Mid Slot') }
end
