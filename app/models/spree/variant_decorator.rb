module Spree 
  Variant.class_eval do 
    has_many :stock_records
    has_and_belongs_to_many :container_taxons, :join_table => 'spree_variants_container_taxons'
    
    def add_count(num)
      self.count_on_hand += num
    end
    
  end
end