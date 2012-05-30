object @container_taxonomy

if set = params[:set]
  extends "spree/api/v1/container_taxonomies/#{set}"
else
  attributes *container_taxonomy_attributes

  child :root => :root do
    attributes *container_taxon_attributes

    child :variants => :variants do
      attributes *variant_attributes
    end

    child :children => :container_taxons do
      attributes *container_taxon_attributes

      child :variants => :variants do
        attributes *variant_attributes
      end
    end
    
  end
end