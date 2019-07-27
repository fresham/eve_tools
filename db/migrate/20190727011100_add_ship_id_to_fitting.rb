class AddShipIdToFitting < ActiveRecord::Migration[5.2]
  def change
    add_reference :fittings, :ship, foreign_key: true
  end
end
