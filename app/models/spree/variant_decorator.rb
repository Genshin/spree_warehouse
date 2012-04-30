module Spree 
  Variant.class_eval do 
    has_many :stock_records
    has_many :variant_container_taxons
    has_many :container_taxons, :through => :variant_container_taxons

    attr_accessible :visual_code, :variant_container_taxons

    def add_count(num)
      self.count_on_hand += num
    end
    
    def remove_count(num)
      self.count_on_hand = self.count_on_hand - num
    end
    
  end
end