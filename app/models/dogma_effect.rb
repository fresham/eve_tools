class DogmaEffect < ApplicationRecord
  self.table_name = 'dgmEffects'
  has_many :dogma_type_effects
end
