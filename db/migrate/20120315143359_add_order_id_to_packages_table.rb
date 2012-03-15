class AddOrderIdToPackagesTable < ActiveRecord::Migration
  def change
    add_column :spree_packages, :order_id, :integer
  end
end
