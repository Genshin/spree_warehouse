class RenameSpreeVariantsContainerTaxonsToSpreeVariantContainerTaxons < ActiveRecord::Migration
  def change
    rename_table :spree_variants_container_taxons, :spree_variant_container_taxons
  end
end
