class AddQuantityToInventoryUnitsTable < ActiveRecord::Migration
  def change
    add_column :spree_inventory_units, :quantity, :integer
  end
end
