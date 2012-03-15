module Spree
  class Package < ActiveRecord::Base
    belongs_to :order
  end
end