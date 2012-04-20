FactoryGirl.define do
  factory :container_taxon, :class => Spree::ContainerTaxon do
    name 'Rack#1'
    container_taxonomy { Factory(:container_taxonomy) }
    parent_id nil
  end
end