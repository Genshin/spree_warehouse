object @shipment

attributes *shipment_attributes
node(:order_id) { |shipment| shipment.order.number }

child :shipping_method => :shipping_method do
  attributes :name, :zone_id, :shipping_category_id
end

child :inventory_units => :inventory_units do 
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
end