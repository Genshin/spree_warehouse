class CreateSpreeVisualCodes < ActiveRecord::Migration
  def change
    create_table :spree_visual_codes do |t|
      t.string :code
      t.integer :type

      t.timestamps
    end
  end
end
