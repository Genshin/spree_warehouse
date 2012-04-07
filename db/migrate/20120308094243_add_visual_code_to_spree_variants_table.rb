class AddVisualCodeToSpreeVariantsTable < ActiveRecord::Migration
  def change
    add_column :spree_variants, :visual_code, :string
  end
end
