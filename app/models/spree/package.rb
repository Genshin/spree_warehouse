module Spree
  class Package < ActiveRecord::Base
    belongs_to :shipment
    
  end
end