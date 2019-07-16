class CreateFittings < ActiveRecord::Migration[5.2]
  def change
    create_table :fittings do |t|
      t.string :name
      t.text :original_text
      t.references :doctrine, foreign_key: true

      t.timestamps
    end
  end
end
