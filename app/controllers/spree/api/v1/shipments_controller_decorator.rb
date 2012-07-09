module Spree
  module Api
    module V1
      ShipmentsController.class_eval do

      	def picking_list
          @shipments = @order.shipments
        end
        
      end
    end
  end
end