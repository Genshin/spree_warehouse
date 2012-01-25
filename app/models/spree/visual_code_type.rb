class Spree::VisualCodeType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  belongs_to :visual_code
end
