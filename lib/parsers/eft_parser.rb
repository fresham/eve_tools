module Parsers
  class EftParser
    OFFLINE_SUFFIX = '/OFFLINE'.freeze
    NAME_CHARS = '[^,/\[\]]'.freeze
    IGNORE_PATTERN = /^\[.+?\]$/.freeze
    MODULE_PATTERN = /^(?<name>#{NAME_CHARS}+?)(,\s*(?<charge>#{NAME_CHARS}+?))?(?<offline>\s*#{OFFLINE_SUFFIX}})?(\s*\[(?<mutation>\d+?)\])?$/.freeze
    DRONE_CARGO_PATTERN = /^(?<name>#{NAME_CHARS}+?) x(?<quantity>\d+?)$/

    def self.parse(fitting_text)
      items = {}

      ship, name = parse_header(fitting_text.lines.first)
      items[ship] = { quantity: 1, location: :hull }

      fitting_text.lines[1..-1].each do |line|
        next if ignore_line?(line)

        parse_line(line).each do |inventory_type, quantity|
          items[inventory_type] = 0 unless items.has_key?(inventory_type)
          items[inventory_type] += quantity
        end
      end

      { name: name, items: items }
    end

    def self.ignore_line?(line)
      line.blank? || line[0..5] == '[Empty'
    end

    def self.parse_line(line)
      items = {}

      if line_match = line.strip.match(/^(.*?)\s+x(\d+)$/)
        items[line_match[1]] = Integer(line_match[2])
      else
        items[line.strip] = 1
      end

      items
    end

    def self.parse_header(line)
      if header_match = line.match(/\[(.*?),\s+(.*?)\]/)
        header_match[1..2]
      else
        throw 'Invalid EFT header'
      end
    end

    def self.read_sections(fitting_text)
      fitting_text.split("\n\n\n").map do |section_text|
        section = []

        lines = section_text.lines.map(&:strip).reject { |line| line.blank? }
        lines.each do |line|
          case line
          when IGNORE_PATTERN
            next
          when DRONE_CARGO_PATTERN, MODULE_PATTERN
            item_hash = $LAST_MATCH_INFO.named_captures.symbolize_keys
            item_hash[:quantity] = item_hash[:quantity].to_i if item_hash[:quantity].present?
            section << item_hash
          end
        end

        section
      end
    end
  end
end
