module Parsers
  class EftParser
    def self.parse(fitting_text)
      items = {}

      ship, name = parse_header(fitting_text.lines.first)
      items[ship] = 1

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
  end
end
