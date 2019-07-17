require 'parsers/eft_parser'

module FittingProcessor
  def self.populate_fitting_data(fitting, fitting_text)
    parser_result = Parsers::EftParser.parse(fitting_text)

    fitting.update(name: parser_result[:name])

    parser_result[:items].each do |name, quantity|
      inventory_type = InventoryType.find_by(typeName: name)

      unless inventory_type.present?
        fitting.errors[:base] << "Invalid item name: #{name}"
        return
      end

      FittingItem.create(fitting: fitting, inventory_type: inventory_type, quantity: quantity)
    end
  end
end
