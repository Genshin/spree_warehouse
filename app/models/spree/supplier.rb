module Spree
  class Supplier < ActiveRecord::Base 
  	has_many :stock_records

  	attr_accessible :name, :company, :address1, :address2, :city, :zipcode, 
  	                :phone_number, :mobile_number, :email, :website
  	                
  end
end