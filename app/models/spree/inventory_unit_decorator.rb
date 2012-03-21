module Spree
  InventoryUnit.class_eval do
    belongs_to :package
  end
end