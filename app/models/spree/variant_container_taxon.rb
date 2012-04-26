module Spree
  class VariantContainerTaxon < ActiveRecord::Base
    belongs_to :variant
    belongs_to :container_taxon 

    scope :active, where(:deactivated_at => nil)
    scope :deactivated, where('deactivated_at IS NOT NULL')
  end
end