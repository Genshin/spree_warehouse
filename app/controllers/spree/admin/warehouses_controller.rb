module Spree
  module Admin
    class WarehousesController < BaseController
      #respond_to :html, :json , :xml
      def index
        @warehouses = Warehouse.all
        respond_to do |format|
          format.html
          format.xml  { render :xml => @warehouses}
          format.json { render :json => @warehouses}
        end
      end
      
      def new
        @warehouse = Warehouse.new
        flash[:notice] = "Running New"
        respond_with(@warehouse)
      end
    
      def create
        @warehouse = Warehouse.new(params[:warehouse])
        flash[:notice] = "Warehouse was successfully created." if @warehouse.save
        redirect_to admin_warehouse_path(@warehouses)

      end

      def show
        @warehouse = Warehouse.find_by_id!(params[:id])
        respond_with(@warehouse)
      end 

      def edit
        @warehouse = Warehouse.find(params[:id])
      end
     
    end  
  end
end
