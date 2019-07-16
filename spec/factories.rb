FactoryBot.define do
  factory :inventory_type do
    typeName { 'Sensor Booster II' }
    group
  end

  factory :inventory_type_material do
    quantity { 1 }
    association :input, factory: :inventory_type
    association :output, factory: :inventory_type
  end

  factory :group do
    groupName { 'Sensor Booster' }
  end
end
