module Spree
  class Stock < ActiveRecord::Base
    belongs_to :stock_receipt
    belongs_to :container_taxon
    belongs_to :variant
    
    after_create :add_count_to_variant
    
    private
    
    def add_count_to_variant
      if self.variant
        self.variant.add_count(self.count)
        self.variant.save!
      end
    end
    
  end
end