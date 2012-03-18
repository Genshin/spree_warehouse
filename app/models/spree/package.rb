module Spree
  class Package < ActiveRecord::Base
    belongs_to :shipment
    belongs_to :container_taxon
  end
end