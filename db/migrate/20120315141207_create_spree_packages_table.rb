class CreateSpreePackagesTable < ActiveRecord::Migration
  def change
    create_table :spree_packages do |t|
      t.string :tracking_number
      t.timestamps
    end
  end
end
