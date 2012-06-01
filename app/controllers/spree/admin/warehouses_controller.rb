module Spree
  module Admin
    class WarehousesController < ResourceController

      def edit
        @container_taxonomies = ContainerTaxonomy.all
        @warehouse = Warehouse.find(params[:id])
      end
      
    end
  end
end