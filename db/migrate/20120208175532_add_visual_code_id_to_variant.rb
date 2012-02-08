class AddVisualCodeIdToVariant < ActiveRecord::Migration
  def change
    add_column :spree_variants, :visual_code_id, :integer
  end
end
