attributes *container_taxonomy_attributes

child :root => :root do
  attributes *container_taxon_attributes

  child :children => :container_taxons do
    attributes *container_taxon_attributes

    extends "spree/api/v1/container_taxons/container_taxons"
  end
end