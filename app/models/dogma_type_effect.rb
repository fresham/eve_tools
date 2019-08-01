class DogmaTypeEffect < ApplicationRecord
  self.table_name = 'dgmTypeEffects'
  belongs_to :inventory_type, foreign_key: :typeID
  belongs_to :dogma_effect, foreign_key: :effectID
end
