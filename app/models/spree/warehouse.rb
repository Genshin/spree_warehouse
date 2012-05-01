module Spree
  class Warehouse < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :name

    attr_accessible :name, :code, :location, :details
  end
end
