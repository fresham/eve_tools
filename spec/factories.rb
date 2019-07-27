FactoryBot.define do
  factory :staging do
    name { "Jita" }
  end

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

  factory :doctrine do
    name { 'Entosis' }
  end

  factory :fitting do
    name { 'Tristan' }
    doctrine
    association :ship, factory: :inventory_type
  end
end
