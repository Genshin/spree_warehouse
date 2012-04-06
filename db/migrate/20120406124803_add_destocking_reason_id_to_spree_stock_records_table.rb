class AddDestockingReasonIdToSpreeStockRecordsTable < ActiveRecord::Migration
  def change
    change_table :spree_stock_records do |t|
      t.references :destocking_reason
    end
  end
end
