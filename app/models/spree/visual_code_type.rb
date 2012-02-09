class Spree::VisualCodeType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  has_many :visual_codes
end
