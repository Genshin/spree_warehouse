module Spree
  module Api
    module V1
      class InventoryUnitsController < Spree::Api::V1::BaseController

        before_filter :iu, :only => [:show, :pick]

        def show
        end

        def pick
          unless @inventory_unit.picked?
            @inventory_unit.send("pick")
          else
            render :inventory_unit_already_picked, :status => 200
          end  
        end

        private

        def iu
          @inventory_unit = InventoryUnit.find(params[:id]) 
        end

      end
    end
  end
end