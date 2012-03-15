module Spree
  LineItem.class_eval do 
    has_many :packages, :through => :package_line_items
  end
end