FactoryGirl.define do
  sequence(:unique_name) { |n| "Name #{n}" }

  factory :warehouse do
    name { Factory.next(:unique_name) }
    details 'Warehouse Details'
  end
end
