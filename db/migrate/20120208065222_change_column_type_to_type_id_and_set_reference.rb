class ChangeColumnTypeToTypeIdAndSetReference < ActiveRecord::Migration
  def up
    drop_table :spree_visual_codes
    create_table :spree_visual_codes do |t|
      t.references :spree_visual_types  
      t.references :product 
      t.string :code
    end
  end

  def down
    drop_table :spree_visual_codes
    create_table :spree_visual_codes do |t|
      t.string :code
      t.integer :product_id
      t.integer :type
    end
  end
end
