class AddPackageIdToInventoryUnitsTable < ActiveRecord::Migration
  def change
    change_table :spree_inventory_units do |t|
      t.references :package
    end
  end
end
