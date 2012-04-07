class CreateSpreeStockRecordsTable < ActiveRecord::Migration
  def change
    create_table :spree_stock_records do |t|
      t.string :order_number
      t.integer :quantity
      t.timestamps
    end
  end
end
