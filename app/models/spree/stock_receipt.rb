module Spree
  class StockReceipt < ActiveRecord::Base
    has_many :stock
  end
end