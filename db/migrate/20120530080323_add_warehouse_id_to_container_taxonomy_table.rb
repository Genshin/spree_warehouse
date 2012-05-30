class AddWarehouseIdToContainerTaxonomyTable < ActiveRecord::Migration
  def change
    change_table :spree_container_taxonomies do |t|
      t.references :warehouse
    end
  end
end
