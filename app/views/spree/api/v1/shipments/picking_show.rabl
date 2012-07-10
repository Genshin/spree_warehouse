object @shipment

attributes *shipment_attributes
node(:order_id) { |shipment| shipment.order.number }

child :shipping_method => :shipping_method do
  attributes :name, :zone_id, :shipping_category_id
end

child :inventory_units => :inventory_units do 
  extends "spree/api/v1/inventory_units/show"
end