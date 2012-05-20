object false
node(:attributes) { [*container_taxon_attributes] }
node(:required_attributes) { required_fields_for(Spree::ContainerTaxon) }