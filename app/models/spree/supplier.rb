module Spree
  class Supplier < ActiveRecord::Base 
  	has_many :stock_records

  	attr_accessible :name, :company
  end
end