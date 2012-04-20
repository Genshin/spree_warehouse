FactoryGirl.define do
  sequence(:warehouse_sequence) { |n| "Warehouse ##{n} - #{rand(9999)}" }

  factory :warehouse , :class => Spree::Warehouse do 
    name { FactoryGirl.generate(:warehouse_sequence) }
  end
end