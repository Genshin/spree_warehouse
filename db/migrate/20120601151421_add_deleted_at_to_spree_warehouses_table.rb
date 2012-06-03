class AddDeletedAtToSpreeWarehousesTable < ActiveRecord::Migration
  def change
  	change_table :spree_warehouses do |t|
      t.timestamp :deleted_at
    end
  end
end
