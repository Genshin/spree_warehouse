module Spree
  class ContainerTaxonomy < ActiveRecord::Base
    validates :name, :presence => true

    has_many :container_taxons
    has_one :root, :conditions => { :parent_id => nil }, :class_name => 'Spree::ContainerTaxon'
    has_and_belongs_to_many :warehouses, :join_table => 'spree_container_taxonomies_warehouses'
    
    accepts_nested_attributes_for :warehouses
    attr_accessible :name

    after_save :set_name
    after_destroy :destroy_root_taxon

    private
      def set_name
        if self.root
          self.root.update_attribute(:name, self.name)
        else
          self.root = ContainerTaxon.create!({ :container_taxonomy_id => self.id, :name => self.name })
        end
      end

      def destroy_root_taxon
        self.root.destroy if self.root
      end
  end
end