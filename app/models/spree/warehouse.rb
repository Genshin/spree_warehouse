module Spree
  class Warehouse < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :name

    has_and_belongs_to_many :container_taxonomies, :join_table => 'spree_container_taxonomies_warehouses'

    attr_accessible :name, :code, :location, :details, :container_taxonomy_ids
  end
end
