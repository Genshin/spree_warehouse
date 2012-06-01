class CreateSpreeContainerTaxonomiesWarehousesTable < ActiveRecord::Migration
  def change
  	create_table :spree_container_taxonomies_warehouses do |t|
      t.references :warehouse
      t.references :container_taxonomy
    end
  end
end