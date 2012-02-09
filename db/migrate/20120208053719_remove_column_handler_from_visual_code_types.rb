class RemoveColumnHandlerFromVisualCodeTypes < ActiveRecord::Migration
  def up
    remove_column :spree_visual_code_types, :handler
  end

  def down
    add_column :spree_visual_code_types, :handler, :string
  end
end
