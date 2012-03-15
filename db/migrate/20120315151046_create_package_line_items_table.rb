class CreatePackageLineItemsTable < ActiveRecord::Migration
  def change
    create_table :spree_package_line_items do |t|
      t.integer :quantity
      t.references :package
      t.references :line_item
      t.timestamps
    end
  end
end
