class AddContainerTaxonIdToStockTable < ActiveRecord::Migration
  def change
    add_column :spree_stock, :container_taxon_id, :integer
  end
end
