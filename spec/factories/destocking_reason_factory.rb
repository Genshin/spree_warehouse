FactoryGirl.define do
  factory :destocking_reason, :class => Spree::DestockingReason do 
    name "destock"
    description "No description"
  end
end