module EFT
  OFFLINE_SUFFIX = '/OFFLINE'.freeze
  NAME_CHARS = '[^,/\[\]]'.freeze
  IGNORE_PATTERN = /^\[.+?\]$/.freeze
  HEADER_PATTERN = /\[(?<ship>[\w\s]+),\s*(?<name>.+)\]/.freeze
  MODULE_PATTERN = /^(?<name>#{NAME_CHARS}+?)(,\s*(?<charge>#{NAME_CHARS}+?))?(?<offline>\s*#{OFFLINE_SUFFIX}})?(\s*\[(?<mutation>\d+?)\])?$/.freeze
  DRONE_CARGO_PATTERN = /^(?<name>#{NAME_CHARS}+?) x(?<quantity>\d+?)$/

  def self.import_fitting(fitting_text)
    fitting = Fitting.new

    sections = fitting_text.split(/\n\n\n?/)
    header = parse_header(sections.shift)
    fitting.name = header[:name]
    fitting.ship = header[:ship]

    sections.each do |section|
      section_items = {}
      slot_types = Set.new

      section.each_line do |line|
        if match = line.match(DRONE_CARGO_PATTERN)
          mod = InventoryType.find_by(typeName: match[:name])
          raise "Cannot find module `#{match[:name]}`" if mod.blank?
          slot_types.add(mod.slot)
          section_items[mod.id] ||= { quantity: 0, fitted: false }
          section_items[mod.id][:quantity] += match[:quantity].to_i || 1
        elsif match = line.match(MODULE_PATTERN)
          mod = InventoryType.find_by(typeName: match[:name])
          raise "Cannot find module `#{match[:name]}`" if mod.blank?
          slot_types.add(mod.slot)
          section_items[mod.id] ||= { quantity: 0, fitted: true }
          section_items[mod.id][:quantity] += 1
        end
      end

      slot = if section_items.values.all? { |i| i[:fitted] }
        if slot_types == Set['Low Slot']
          'Low Slot'
        elsif slot_types == Set['Mid Slot']
          'Mid Slot'
        elsif slot_types == Set['High Slot']
          'High Slot'
        elsif slot_types == Set['Rig Slot']
          'Rig Slot'
        end
      else
        if slot_types == Set['Drone Bay']
          'Drone Bay'
        else
          'Cargo Bay'
        end
      end

      section_items.each do |type_id, item|
        fitting.fitting_items.build(inventory_type_id: type_id, slot: slot, quantity: item[:quantity])
      end
    end

    fitting
  end

  def self.parse_header(fitting_text)
    match = fitting_text.each_line.first.match(HEADER_PATTERN)
    raise 'Invalid EFT header' if match.blank?

    ship = InventoryType.find_by(typeName: match[:ship])
    raise "Unknown ship type: `#{match[:ship]}`" if ship.blank?

    { name: match[:name], ship: ship }
  end
end
