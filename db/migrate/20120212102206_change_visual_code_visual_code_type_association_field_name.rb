class ChangeVisualCodeVisualCodeTypeAssociationFieldName < ActiveRecord::Migration
  def change
    change_table :spree_visual_codes do |t|
      t.rename :type_id, :visual_code_type_id
    end

    remove_index :spree_visual_codes, :type_id
    add_index :spree_visual_codes, :visual_code_type_id
  end
end

