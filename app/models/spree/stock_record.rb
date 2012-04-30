module Spree
  class StockRecord < ActiveRecord::Base
    belongs_to :variant
    belongs_to :container_taxon
    belongs_to :destocking_reason

    validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true
    
    scope :restocked, where('direction = ?','in')
    scope :destocked, where('direction = ?','out')

 
    after_create :modify_variant_count
    
    private
    
    def modify_variant_count
      unless self.variant.nil?
        if self.direction == 'in'
          self.variant.add_count(self.quantity)
        else
          self.variant.remove_count(self.quantity)
        end
        self.variant.save!
        
      end
    end

  end
end