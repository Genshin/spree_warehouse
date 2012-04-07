class AddCanDeleteToSpreeVisualCodeTypesTable < ActiveRecord::Migration
  def change
    add_column :spree_visual_code_types, :can_delete, :boolean , :default => true
  end
end
