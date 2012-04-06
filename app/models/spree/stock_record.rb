module Spree
  class StockRecord < ActiveRecord::Base
    belongs_to :variant
    belongs_to :container_taxon
    belongs_to :destocking_reason
    
    scope :restocked, where('direction = ?','in')
    scope :destocked, where('direction = ?','out')

 
    after_create :add_count_to_variant
    
    private
    
    def add_count_to_variant
      if self.variant
        self.variant.add_count(self.quantity)
        self.variant.save!
      end
    end
    

    
  end
end