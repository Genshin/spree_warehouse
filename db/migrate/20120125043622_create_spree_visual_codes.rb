class CreateSpreeVisualCodes < ActiveRecord::Migration
  def change
    create_table :spree_visual_codes do |t|
      t.string :code
      t.references :type

      t.timestamps
    end
    add_index :spree_visual_codes, :type_id
  end
end
