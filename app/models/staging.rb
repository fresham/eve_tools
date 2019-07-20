class Staging < ApplicationRecord
  has_many :staged_fittings
  has_many :fittings, through: :staged_fittings
  accepts_nested_attributes_for :staged_fittings, allow_destroy: true
end
