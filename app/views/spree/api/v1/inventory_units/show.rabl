object @inventory_unit
attributes :state

child :variant => :variant do 
  attributes :id, :name, :sku

  child :variant_container_taxons => :variant_container_taxons do 
    attributes :quantity

    child :container_taxon => :container_taxon do 
      attributes :name
    end
  end

end