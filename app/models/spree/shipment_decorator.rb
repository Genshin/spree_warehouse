module Spree
  Shipment.class_eval do 
    has_many :packages
  end
end