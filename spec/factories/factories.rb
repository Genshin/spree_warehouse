FactoryGirl.define do
  sequence(:unique_name) { |n| "Name #{n}" }

  factory :warehouse , :class => Spree::Warehouse do 
    name { Factory.next(:unique_name) }
    details 'Warehouse Details'
  end
end

