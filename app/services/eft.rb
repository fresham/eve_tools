module EFT
  OFFLINE_SUFFIX = '/OFFLINE'.freeze
  NAME_CHARS = '[^,/\[\]]'.freeze
  IGNORE_PATTERN = /^\[.+?\]$/.freeze
  HEADER_PATTERN = /^\[(?<ship>[\w\s]+),\s*(?<name>.+)\]$/.freeze
  MODULE_PATTERN = /^(?<name>#{NAME_CHARS}+?)(,\s*(?<charge>#{NAME_CHARS}+?))?(?<offline>\s*#{OFFLINE_SUFFIX}})?(\s*\[(?<mutation>\d+?)\])?$/.freeze
  DRONE_CARGO_PATTERN = /^(?<name>#{NAME_CHARS}+?) x(?<quantity>\d+?)$/

  def self.import_fitting(fitting_text)
    fitting = Fitting.new

    normalized_text = fitting_text.gsub(/\r\n?/, "\n")
    match = normalized_text.each_line.first.match(HEADER_PATTERN)
    raise 'Invalid EFT header' if match.blank?

    ship = InventoryType.find_by(typeName: match[:ship])
    raise "Unknown ship type: `#{match[:ship]}`" if ship.blank?

    fitting.name = match[:name]
    fitting.ship = ship

    sections = normalized_text.split(/\n\n\n?/)
    sections.each do |section|
      section_items = []
      slot_types = Set.new

      section.each_line do |line|
        if line.match(IGNORE_PATTERN)
          next
        elsif match = line.match(DRONE_CARGO_PATTERN)
          mod = InventoryType.find_by(typeName: match[:name])
          raise "Cannot find module `#{match[:name]}`" if mod.blank?
          slot_types.add(mod.fitting_slot)
          section_items << { type_id: mod.id, quantity: match[:quantity].to_i || 1, fitted: false }
        elsif match = line.match(MODULE_PATTERN)
          mod = InventoryType.find_by(typeName: match[:name])
          raise "Cannot find module `#{match[:name]}`" if mod.blank?
          slot_types.add(mod.fitting_slot)
          section_items << { type_id: mod.id, quantity: 1, fitted: true }
        end
      end

      slot = if section_items.all? { |i| i[:fitted] }
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

      section_items.each do |item|
        fitting.fitting_items.build(inventory_type_id: item[:type_id], slot: slot, quantity: item[:quantity])
      end

    end

    fitting
  end
end
