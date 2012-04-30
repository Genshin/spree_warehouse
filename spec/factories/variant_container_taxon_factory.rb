FactoryGirl.define do
  factory :variant_container_taxon , :class => Spree::VariantContainerTaxon do 
  	quantity 99
    association :variant
    association :container_taxon
    deactivated_at nil
  end
end