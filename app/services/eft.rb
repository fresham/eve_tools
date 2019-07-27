module EFT
  OFFLINE_SUFFIX = '/OFFLINE'.freeze
  NAME_CHARS = '[^,/\[\]]'.freeze
  IGNORE_PATTERN = /^\[.+?\]$/.freeze
  HEADER_PATTERN = /\[(?<ship>[\w\s]+),\s*(?<name>.+)\]/.freeze
  MODULE_PATTERN = /^(?<name>#{NAME_CHARS}+?)(,\s*(?<charge>#{NAME_CHARS}+?))?(?<offline>\s*#{OFFLINE_SUFFIX}})?(\s*\[(?<mutation>\d+?)\])?$/.freeze
  DRONE_CARGO_PATTERN = /^(?<name>#{NAME_CHARS}+?) x(?<quantity>\d+?)$/

  def self.import_fitting(fitting_text)
    fitting = Fitting.new

    header = parse_header(fitting_text)
    fitting.name = header[:name]
    fitting.ship = header[:ship]

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
