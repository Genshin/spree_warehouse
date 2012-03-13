module Spree
  class Stock < ActiveRecord::Base
    belongs_to :stock_receipt
  end
end