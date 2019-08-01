class AddSlotToFittingItem < ActiveRecord::Migration[5.2]
  def change
    add_column :fitting_items, :slot, :string
  end
end
