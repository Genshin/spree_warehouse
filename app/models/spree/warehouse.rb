module Spree
  class Warehouse < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :name

    has_many :container_taxonomies

    attr_accessible :name, :code, :location, :details, :container_taxonomy_ids
  end
end
