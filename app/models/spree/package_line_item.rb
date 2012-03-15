module Spree
  class PackageLineItem < ActiveRecord::Base
    belongs_to :package
    belongs_to :line_item
  end
end