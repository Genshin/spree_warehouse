module Spree
  Product.class_eval do 
    accepts_nested_attributes_for :master
  end
end