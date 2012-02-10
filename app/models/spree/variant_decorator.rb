Spree::Variant.class_eval do
  has_one :visual_code

  def self.find_bar_code(code)
    Spree::Variant.where(:visual_code_id => Spree::VisualCode.where({:code => code, :type_id => Spree::VisualCodeType.where(:name => "BarCode")}))
  end

  def self.set_bar_code(code)
  end
end
