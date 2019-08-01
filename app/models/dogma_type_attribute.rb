class DogmaTypeAttribute < ApplicationRecord
  self.table_name = 'dgmTypeAttributes'
  belongs_to :inventory_type, foreign_key: :typeID
  belongs_to :dogma_attribute, foreign_key: :attributeID
end
