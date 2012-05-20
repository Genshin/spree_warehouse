object @container_taxon
attributes *container_taxon_attributes

node do |t|
  child t.children => :container_taxons do
    attributes *container_taxon_attributes
  end
end