class Group < ApplicationRecord
  self.table_name = 'invGroups'
  belongs_to :category, foreign_key: :categoryID, required: false
end
