class AddVariantIdToStockTable < ActiveRecord::Migration
  def change
    add_column :spree_stock, :variant_id, :integer
  end
end
