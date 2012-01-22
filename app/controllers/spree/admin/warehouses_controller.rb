module Spree
  module Admin
    class WarehousesController < BaseController
      respond_to :html, :json , :xml
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
      end
    
      def create
        @warehouse = Warehouse.new(params[:warehouse])
        respond_to do |format|
          if @warehouse.save
            format.html { redirect_to [:admin,@warehouse], notice: 'Warehouse was successfully created.' }
            format.json { render json: @warehouse, status: :created, location: @warehouse }
          else
            format.html { render action: "new" }
            format.json { render json: @warehouse.errors, status: :unprocessable_entity }
          end
        end
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
