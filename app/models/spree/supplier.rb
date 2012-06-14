module Spree
  class Supplier < ActiveRecord::Base 
  	has_many :stock_records
  end
end