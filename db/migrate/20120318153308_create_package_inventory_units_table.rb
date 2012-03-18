class CreatePackageInventoryUnitsTable < ActiveRecord::Migration
  def change
    create_table :spree_package_inventory_units do |t|
      t.integer :quantity
      t.references :package
      t.references :inventory_unit
      t.timestamps
    end
  end
end
