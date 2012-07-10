object @inventory_unit
attributes :state

child :variant => :variant do 
  attributes :id, :name, :sku
end