module Spree
  class Package < ActiveRecord::Base
    belongs_to :shipment
    belongs_to :container_taxon
    has_many :inventory_units, :through => :package_inventory_units
  end
end