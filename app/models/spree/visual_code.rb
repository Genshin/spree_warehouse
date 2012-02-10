class Spree::VisualCode < ActiveRecord::Base
  validates :code, :presence => true
  validates :type_id, :presence => true
  
  has_many :variants
  #has_and_belongs_to_many :variants
  has_one :visual_code_type
end
