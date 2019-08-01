class Category < ApplicationRecord
  self.table_name = 'invCategories'
  has_many :groups, foreign_key: :categoryID
end
