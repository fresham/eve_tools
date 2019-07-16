class Fitting < ApplicationRecord
  belongs_to :doctrine, optional: true
  has_many :fitting_items
  has_many :items, through: :fitting_items, source: :inventory_type
end
