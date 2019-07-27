class Fitting < ApplicationRecord
  belongs_to :doctrine, optional: true
  has_many :fitting_items, dependent: :destroy
  has_many :items, through: :fitting_items, source: :inventory_type
  has_many :staged_fittings
  has_many :stagings, through: :staged_fittings
  belongs_to :ship, class_name: 'InventoryType'

  validates :ship, presence: true
  validates :name, presence: true
end
