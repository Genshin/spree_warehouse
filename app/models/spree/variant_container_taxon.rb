module Spree
  class VariantContainerTaxon < ActiveRecord::Base
    belongs_to :variant
    belongs_to :container_taxon 

    validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true

    attr_accessible :quantity, :container_taxon_id, :variant_id 

    scope :active, where(:deactivated_at => nil)
    scope :deactivated, where('deactivated_at IS NOT NULL')

    def activate
      self.deactivated_at = nil
    end

    def deactivate
      self.deactivated_at = Time.now
    end

    def active?
      self.deactivated_at.nil?
    end
  end
end