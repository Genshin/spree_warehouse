module Spree
  class VariantContainerTaxon < ActiveRecord::Base
    belongs_to :variant
    belongs_to :container_taxon 
  end
end