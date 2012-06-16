FactoryGirl.define do
  sequence(:company) { "#{Faker::Name.name} Ltd." }
  
  factory :supplier , :class => Spree::Supplier do 
    company
  end
end

