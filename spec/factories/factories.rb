FactoryGirl.define do
  sequence(:name) { |n| "Name #{n}" }
  sequence(:unique_vc_type) { |n| "Name #{n}" }
  sequence(:unique_taxonomy_name) { |n| "Storage Hall #{n}" }
  sequence(:unique_container_taxon) { |n| "Shelve #{n}" }
 
  factory :warehouse , :class => Spree::Warehouse do 
    name
  end

  factory :visual_code, :class => Spree::VisualCode do
    code { FactoryGirl.generate(:name) }
    visual_code_type { Spree::VisualCodeType.where(:name => 'QR Code') }
  end

  factory :visual_code_type, :class => Spree::VisualCodeType do
    name { FactoryGirl.generate(:unique_vc_type) }
  end
  
  factory :container_taxonomy, :class => Spree::ContainerTaxonomy do 
    name { FactoryGirl.generate(:unique_taxonomy_name)}
  end
  
  factory :container_taxon, :class => Spree::ContainerTaxon do 
    name { FactoryGirl.generate(:unique_container_taxon)}
  end

end

