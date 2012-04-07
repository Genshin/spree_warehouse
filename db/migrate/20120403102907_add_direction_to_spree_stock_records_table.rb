class AddDirectionToSpreeStockRecordsTable < ActiveRecord::Migration
  def change
    change_table :spree_stock_records do |t|
      t.string :direction
    end
  end
end
