class Fitting < ApplicationRecord
  belongs_to :doctrine, optional: true
  has_many :fitting_items, dependent: :destroy
  has_many :items, through: :fitting_items, source: :inventory_type
  has_many :staged_fittings
  has_many :stagings, through: :staged_fittings
  belongs_to :ship, class_name: 'InventoryType'

  validates :ship, presence: true
  validates :name, presence: true

  delegate :low_slots, :mid_slots, :high_slots, :rig_slots, :drones, :cargo, to: :fitting_items

  def eft_block(sorted: false)
    [
      [
        eft_header,
        eft_fitted_section(low_slots, ship.low_slots, '[Empty Low slot]', sorted),
        eft_fitted_section(mid_slots, ship.mid_slots, '[Empty Med slot]', sorted),
        eft_fitted_section(high_slots, ship.high_slots, '[Empty High slot]', sorted),
        eft_fitted_section(rig_slots, ship.rig_slots, '[Empty Rig slot]', sorted)
      ].join("\n\n"),
      eft_cargo_section(drones, sorted),
      eft_cargo_section(cargo, sorted),
    ].compact.join("\n\n\n")
  end

  private

  def eft_header
    "[#{ship.typeName}, #{name}]"
  end

  def eft_fitted_section(fitting_items, number_of_slots, stub_text, sorted=false)
    sort_order = sorted ? 'invTypes.typeName' : :created_at
    fitting_items.joins(:inventory_type).order(sort_order).pluck('invTypes.typeName')
        .fill(stub_text, fitting_items.length...number_of_slots).join("\n")
  end

  def eft_cargo_section(fitting_items, sorted=false)
    return nil if fitting_items.blank?
    sort_order = sorted ? 'invTypes.typeName' : :created_at
    fitting_items.includes(:inventory_type).order(sort_order)
        .map { |item| "#{item.inventory_type.typeName} x#{item.quantity}"}.join("\n")
  end
end
