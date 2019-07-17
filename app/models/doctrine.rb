class Doctrine < ApplicationRecord
  has_many :fittings, dependent: :destroy
end
