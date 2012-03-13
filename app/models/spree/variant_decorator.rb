module Spree 
  Variant.class_eval do 
    has_many :stock
    
    def add_count(num)
      self.count_on_hand += num
    end
    
  end
end