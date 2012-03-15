module Spree
  class Package < ActiveRecord::Base
    belongs_to :order
    belongs_to :container_taxon
    has_many :line_items, :through => :package_line_items
  end
end