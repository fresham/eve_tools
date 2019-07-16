class CreateFittingItems < ActiveRecord::Migration[5.2]
  def change
    create_table :fitting_items do |t|
      t.references :inventory_type, references: :invTypes
      t.references :fitting, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
