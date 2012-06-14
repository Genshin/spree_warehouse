class AddSupplierIdToSpreeStockRecordsTable < ActiveRecord::Migration
  def change
  	change_table :spree_stock_records do |t|
      t.references :supplier
  	end
  end
end