class CreateStockReceiptsTable < ActiveRecord::Migration
  def change
    create_table :spree_stock_receipts do |t|
      t.string :supplier
      t.string :order_number
      t.timestamps
    end
  end
end
