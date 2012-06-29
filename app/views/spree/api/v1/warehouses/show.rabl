object @warehouse
attributes *warehouse_attributes

child :container_taxonomies => :container_taxonomies do
  attributes *container_taxonomy_attributes

  child :root => :root do
    attributes *container_taxon_attributes

    child :children => :container_taxons do
      attributes *container_taxon_attributes
    end
  end
end