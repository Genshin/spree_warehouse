module Spree
  module Api
    module V1
      class WarehousesController < Spree::Api::V1::BaseController

        def index
          @warehouses = Warehouse.all
        end

        def search
          @warehouses = Warehouse.search(params[:q]).result.page(params[:page])
          render :index
        end

        def show
          @warehouse = Warehouse.find(params[:id])
        end

      end
    end
  end
end