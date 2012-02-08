class ChangeVisualCodeTypeReference < ActiveRecord::Migration
  def change
    rename_column :spree_visual_codes, :type, :type_id
    #change_column :spree_visual_codes, :type_id, :references
  end
end
