class AddStockReceiptIdToStockTable < ActiveRecord::Migration
  def change
    add_column :spree_stock, :stock_receipt_id, :integer
  end
end
