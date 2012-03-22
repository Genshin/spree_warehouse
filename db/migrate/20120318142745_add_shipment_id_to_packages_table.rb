class AddShipmentIdToPackagesTable < ActiveRecord::Migration
  def change
    change_table :spree_packages do |t|
      t.references :shipment
    end
  end
end
