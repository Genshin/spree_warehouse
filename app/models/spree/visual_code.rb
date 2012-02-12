class Spree::VisualCode < ActiveRecord::Base
  validates :code, :presence => true
  validates :type_id, :presence => true
  
  has_many :variants
  has_one :visual_code_type

  def self.find_or_create_by_code(code, code_type)
    res = Spree::VisualCode.where({:code => code, :type_id => Spree::VisualCodeType.where(:name => code_type)})
    if res == []
      res = Spree::VisualCode.new
      res.code = code
      res.type_id = Spree::VisualCodeType.where(:name => code_type)
      res.save
    end

    return res
  end
end
