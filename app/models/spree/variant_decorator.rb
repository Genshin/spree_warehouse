module Spree 
  Variant.class_eval do 
    has_many :stock
  end
end