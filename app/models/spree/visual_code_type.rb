module Spree 
  class VisualCodeType < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true
    has_many :visual_codes
    
    def self.barcode
      find_by_name("Barcode")
    end
    
    def can_delete?
      self.can_delete
    end
  end
end
