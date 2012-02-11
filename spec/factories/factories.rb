FactoryGirl.define do
  sequence(:unique_name) { |n| "Name #{n}" }
  sequence(:unique_taxonomy_name) { |n| "Storage Hall #{n}" }
  sequence(:unique_container_taxon) { |n| "Shelve #{n}" }
  


  factory :warehouse , :class => Spree::Warehouse do 
    name { Factory.next(:unique_name) }
    details 'Warehouse Details'
  end

  factory :visual_code, :class => Spree::VisualCode do
    code { Factory.next(:unique_name) }
    type Spree::VisualCodeType.where(:name => 'QR Code')
  end

  factory :visual_code_type, :class => Spree::VisualCodeType do
    name { Factory.next(:unique_name) }
    handler 'barcode'
  end
  
  factory :container_taxonomy, :class => Spree::ContainerTaxonomy do 
    name { Factory.next(:unique_taxonomy_name)}
  end
  
  factory :container_taxon, :class => Spree::ContainerTaxon do 
    name { Factory.next(:unique_container_taxon)}
  end

end

