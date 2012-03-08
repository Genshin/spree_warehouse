module Spree
  Product.class_eval do 
    delegate_belongs_to :master, :visual_code
    #accepts_nested_attributes_for :master, :reject_if => proc { |attributes| attributes['master'].blank? }
    #accepts_nested_attributes_for :master
  end
end