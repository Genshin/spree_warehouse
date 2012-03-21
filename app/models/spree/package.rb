module Spree
  class Package < ActiveRecord::Base
    belongs_to :shipment
    belongs_to :container_taxon
    has_many :inventory_units
    
    before_create :generate_tracking_number
    
    def generate_tracking_number
      return self.tracking_number unless self.tracking_number.blank?
      record = true
      while record
        random = "R#{Array.new(9){rand(9)}.join}"
        record = self.class.where(:tracking_number => random).first
      end
      self.tracking_number = random 
    end

  end
end
