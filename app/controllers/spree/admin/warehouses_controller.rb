module Spree
  module Admin
    class WarehousesController < ResourceController

      def edit
        @container_taxonomies = ContainerTaxonomy.all
        @warehouse = Warehouse.find(params[:id])
      end

      def update
        @warehouse = Warehouse.find(params[:warehouse][:id])
        respond_to do |format|
          if @warehouse.update_attributes(params[:warehouse])
            format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @warehouse.errors, status: :unprocessable_entity }
          end
        end
      end
  
    end
  end
end
