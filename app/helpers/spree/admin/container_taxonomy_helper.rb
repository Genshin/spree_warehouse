module Spree
  module Admin
    module ContainerTaxonomyHelper
      def container_taxonomy_selected?(ct)
        if @warehouse && @warehouse.container_taxonomies.exists?
          @warehouse.container_taxonomies.include?(ct)
        else
          false
        end
      end
    end
  end
end