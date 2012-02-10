Spree::Variant.class_eval do
  has_one :visual_code 
  
  after_create :set_visual_code
  
  def self.find_bar_code(code)
    Spree::Variant.where(:visual_code_id => Spree::VisualCode.where({:code => code, :type_id => Spree::VisualCodeType.where(:name => "BarCode")}))
  end

  def self.set_bar_code(code)
  end
  
  # attempting to setup up a method to handle set either and type of visual code dr.J
  def self.set_visual_code(visual_code_id,type_id)
    debugger
    1
    #vc = Spree::VisualCode.where(:visual => code) unless code.blank?
    #self.visual_code_id = vc.id unless vc.nil?  
  end  
  
end
