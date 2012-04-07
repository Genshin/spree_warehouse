class AddContainerTaxonIdToSpreePackagesTable < ActiveRecord::Migration
  def change
    change_table :spree_packages do |t|
      t.references :container_taxon
    end
  end
end
