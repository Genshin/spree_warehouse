class Spree::VisualCodeType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
end
