module Spree
  Shipment.class_eval do 
    has_many :packages
    has_one :master_package, :class_name => 'Spree::Package'
    
    accepts_nested_attributes_for :packages
        
    def package
      @package ||= self.packages.last
    end
  end
end