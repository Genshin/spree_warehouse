object @warehouse
attributes *warehouse_attributes

child :container_taxonomies => :container_taxonomies do
  attributes *container_taxonomy_attributes
end