FactoryGirl.define do
  sequence(:vct_seq) { |n| "Code Type ##{n} - #{rand(9999)}" }

  factory :visual_code_type, :class => Spree::VisualCodeType do
    name { FactoryGirl.generate(:vct_seq) }
  end

  factory :barcode, :class => Spree::VisualCodeType do
    name "Barcode"
    can_delete false
  end
  
end