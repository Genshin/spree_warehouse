module Spree 
  class VisualCodeType < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true
    
    def self.barcode
      find_by_name("Barcode")
    end
    
    def can_delete?
      self.can_delete
    end
  end
end
