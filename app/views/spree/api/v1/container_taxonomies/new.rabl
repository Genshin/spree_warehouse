object false
node(:attributes) { [*container_taxonomy_attributes] }
node(:required_attributes) { required_fields_for(Spree::ContainerTaxonomy) }