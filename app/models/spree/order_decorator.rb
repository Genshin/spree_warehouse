module Spree
  Order.class_eval do 
    has_many :packages
  end
end