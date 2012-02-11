Spree::Variant.class_eval do
  has_one :visual_code

  #returns product variant with the given barcode
  #EG: Spree::Variant.find_by_barcode("12345")
  def self.find_by_barcode(code)
    Spree::Variant.where(:visual_code_id => Spree::VisualCode.where({:code => code, :type_id => Spree::VisualCodeType.where(:name => "Barcode")}))
  end

  #can be called on individual objects
  #EG: Spree::Variant.find(1).set_barcode("12345")
  def set_barcode(code)
    record = self
    record.visual_code_id = Spree::VisualCode.find_or_create_by_code(code, "Barcode")
    record.save
  end
end
