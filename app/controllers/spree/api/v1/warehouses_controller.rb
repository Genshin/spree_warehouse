module Spree
  module Api
    module V1
      class WarehousesController < Spree::Api::V1::BaseController

        def index
          @warehouses = Warehouse.all
        end

        def show
          @warehouse = Warehouse.find(params[:id])
        end

        def new
        end

        def create
          authorize! :create, Warehouse
            
          @warehouse = Warehouse.new(params[:warehouse])
          if @warehouse.save
            render :show, :status => 201
          else
            invalid_resource!(@warehouse)
          end
        end

      end
    end
  end
end