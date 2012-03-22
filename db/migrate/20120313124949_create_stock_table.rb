class CreateStockTable < ActiveRecord::Migration
  def change
    create_table :spree_stock do |t|
      t.integer :count
      t.timestamps
    end
  end
end
