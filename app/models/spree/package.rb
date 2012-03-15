module Spree
  class Package < ActiveRecord::Base
    belongs_to :order
    belongs_to :container_taxon
  end
end