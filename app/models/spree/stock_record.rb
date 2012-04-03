module Spree
  class StockRecord < ActiveRecord::Base
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