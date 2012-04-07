module Spree
  class DestockingReason < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true
    attr_accessible :name, :description
    has_many :stock_records
  end
end