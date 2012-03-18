module Spree
  InventoryUnit.class_eval do 
    has_many :packages, :through => :package_inventory_units
  end
end