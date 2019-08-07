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

  def eft_block
    fitted_sections = [eft_header, eft_lows_section, eft_mids_section, eft_highs_section, eft_rigs_section ]

    [fitted_sections.join("\n\n"), eft_drone_bay_section, eft_cargo_bay_section].compact.join("\n\n\n")
  end

  private

  def eft_header
    "[#{ship.typeName}, #{name}]"
  end

  def eft_lows_section
    low_slots.joins(:inventory_type).pluck('invTypes.typeName')
        .fill('[Empty Low slot]', low_slots.length...ship.low_slots).join("\n")
  end

  def eft_mids_section
    mid_slots.joins(:inventory_type).pluck('invTypes.typeName')
        .fill('[Empty Med slot]', mid_slots.length...ship.mid_slots).join("\n")
  end

  def eft_highs_section
    high_slots.joins(:inventory_type).pluck('invTypes.typeName')
        .fill('[Empty High slot]', high_slots.length...ship.high_slots).join("\n")
  end

  def eft_rigs_section
    rig_slots.joins(:inventory_type).pluck('invTypes.typeName')
        .fill('[Empty Rig slot]', rig_slots.length...ship.rig_slots).join("\n")
  end

  def eft_drone_bay_section
    return nil if drones.blank?
    drones.includes(:inventory_type).map { |item| "#{item.inventory_type.typeName} x#{item.quantity}"}.join("\n")
  end

  def eft_cargo_bay_section
    return nil if cargo.blank?
    cargo.includes(:inventory_type).map { |item| "#{item.inventory_type.typeName} x#{item.quantity}"}.join("\n")
  end
end
