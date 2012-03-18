module Spree
  class PackageInventoryUnit < ActiveRecord::Base
    belongs_to :package
    belongs_to :inventory_unit
  end
end