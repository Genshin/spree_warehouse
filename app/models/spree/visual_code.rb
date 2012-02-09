class Spree::VisualCode < ActiveRecord::Base
  validates :code, :presence => true
  validates :type_id, :presence => true

  has_one :visual_code_type
end
