module Spree
  Variant.class_eval do
    belongs_to :visual_code
    accepts_nested_attributes_for :visual_code
    attr_accessible :visual_code, :visual_code_attributes
    
    before_validation :save_vc_type  
    
    def save_vc_type
      if self.visual_code
        self.visual_code.attributes = { :code => self.visual_code.code, :visual_code_type_id => VisualCodeType.barcode.id } 
      end
      true
    end
    #returns product variant with the given barcode
    #EG: Spree::Variant.find_by_barcode("12345")
    def self.find_by_barcode(code)
      Spree::Variant.where(:visual_code_id => Spree::VisualCode.where({:code => code, :visual_code_type_id => Spree::VisualCodeType.where(:name => "Barcode")}))
    end
  
    #can be called on individual objects
    #EG: Spree::Variant.find(1).set_barcode("12345")
    def set_barcode(code)
      record = self
      record.visual_code_id = Spree::VisualCode.find_or_create_by_code(code, "Barcode")
      record.save
    end
    
    def set_primary_barcode(code = nil)
      p = Spree::Product.find(self.product_id)
      if p.has_variants? # write to the current variant
        record = self
        record.visual_code_id = Spree::VisualCode.find_or_create_by_code(code, "Barcode")
      else # write to master variant
        record = p.variants.where(:is_master => true)
        record.visual_code_id = Spree::VisualCode.find_or_create_by_code(code, "Barcode")
      end
      record.save
    end
  end
end
