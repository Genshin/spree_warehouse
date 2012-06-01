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
        @warehouse.deleted_at = Time.now

        respond_to do |format|
          if @warehouse.save
            format.html { redirect_to admin_warehouses_url, :notice => 'Warehouse was successfully deleted.' }
            format.json { head :ok }
          else
            format.html { render :action => "edit" }
            format.json { render :json => [:admin, @warehouse.errors], :status => :unprocessable_entity }
          end
        end
      end

    end
  end
end