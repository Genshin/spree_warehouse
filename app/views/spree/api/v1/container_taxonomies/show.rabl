object @container_taxonomy

if set = params[:set]
  extends "spree/api/v1/container_taxonomies/#{set}"
else
  attributes *container_taxonomy_attributes

  child :root => :root do
      attributes *container_taxon_attributes

    child :children => :container_taxons do
      attributes *container_taxon_attributes
    end
  end
end