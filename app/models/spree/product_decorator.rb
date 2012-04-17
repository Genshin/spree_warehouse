module Spree
  Product.class_eval do 
    delegate_belongs_to :master, :visual_code
    
  end
end