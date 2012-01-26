class Spree::VisualCode < ActiveRecord::Base
  validates_presence_of :code
  validates_presence_of :type
  has_one :visual_code_type
end
