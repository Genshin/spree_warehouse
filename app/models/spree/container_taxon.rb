module Spree
  class ContainerTaxon < ActiveRecord::Base
    acts_as_nested_set :dependent => :destroy

    belongs_to :container_taxonomy
    has_many :stock_records
    has_many :packages
    has_many :variant_container_taxons
    has_many :variants, :through => :variant_container_taxons
     
    before_create :set_permalink

    validates :name, :presence => true

    attr_accessible :name, :parent_id, :position, :icon, :description, :permalink, :container_taxonomy_id

    # Creates permalink based on Stringex's .to_url method
    def set_permalink
      if parent_id.nil?
        self.permalink = name.to_url if self.permalink.blank?
      else
        parent_taxon = Spree::ContainerTaxon.find(parent_id)
        self.permalink = [parent_taxon.permalink, (self.permalink.blank? ? name.to_url : self.permalink.split('/').last)].join('/')
      end
    end

  end
end