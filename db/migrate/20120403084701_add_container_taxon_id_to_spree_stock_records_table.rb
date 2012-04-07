class AddContainerTaxonIdToSpreeStockRecordsTable < ActiveRecord::Migration
  def change
    change_table :spree_stock_records do |t|
      t.references :container_taxon
    end
  end
end
