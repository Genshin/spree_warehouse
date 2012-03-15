class AddContainerTaxonIdToPackagesTable < ActiveRecord::Migration
  def change
    add_column :spree_packages , :container_taxon_id , :integer
  end
end
