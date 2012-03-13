module Spree
  class Stock < ActiveRecord::Base
    belongs_to :stock_receipt
    belongs_to :container_taxon
    belongs_to :variant
  end
end