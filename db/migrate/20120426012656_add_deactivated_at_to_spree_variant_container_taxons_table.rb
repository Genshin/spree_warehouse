class AddDeactivatedAtToSpreeVariantContainerTaxonsTable < ActiveRecord::Migration
  def change
    change_table :spree_variant_container_taxons do |t|
      t.timestamp :deactivated_at
    end
  end
end
