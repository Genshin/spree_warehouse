module Spree
  module Admin
    class WarehousesController < ResourceController

      def edit
        @container_taxonomies = ContainerTaxonomy.all
        @warehouse = Warehouse.find(params[:id])
      end

      def index
      	@warehouses = Warehouse.active
      end

      def destroy
        @warehouse = Warehouse.find(params[:id])
        @warehouse.update_attribute(:deleted_at, Time.now)

        flash.notice = I18n.t('notice_messages.warehouse_deleted')

        respond_with(@warehouse) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end

    end
  end
end