class DogmaAttribute < ApplicationRecord
  self.table_name = 'dgmAttributeTypes'
  has_many :dogma_type_attributes
end
