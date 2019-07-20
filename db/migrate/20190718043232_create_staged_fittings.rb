class CreateStagedFittings < ActiveRecord::Migration[5.2]
  def change
    create_table :staged_fittings do |t|
      t.integer :target_quantity
      t.belongs_to :staging, index: true
      t.belongs_to :fitting, index: true

      t.timestamps
    end
  end
end
