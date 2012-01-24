FactoryGirl.define do
  sequence(:unique_name) { |n| "Name #{n}" }

  factory :warehouse , :class => Spree::Warehouse do 
    name { Factory.next(:unique_name) }
    details 'Warehouse Details'
  end

  factory :visual_code_type, :class => Spree::VisualCodeType do
    name { Factory.next(:unique_name) }
    handler 'barcode'
  end
end

