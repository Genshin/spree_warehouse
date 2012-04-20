FactoryGirl.define do
  factory :stock_record , :class => Spree::StockRecord do 
    quantity 99
    direction "in"
    association :variant
    association :container_taxon
  end
end