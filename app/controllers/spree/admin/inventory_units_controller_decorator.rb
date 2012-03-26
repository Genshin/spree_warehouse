module Spree
  module Admin 
    InventoryUnitsController.class_eval do 
      
      before_filter :load_inventory_unit , :only => [:fire]

      respond_to :html

      def fire
        if @iu.send("#{params[:e]}")
          flash.notice = t(:unit_picked)
        else
          flash[:error] = t(:cannot_perform_operation)
        end
        respond_with(@iu.shipment) { |format| format.html { redirect_to :back } }
      end
      
      private 
      
      def load_inventory_unit
        @iu = InventoryUnit.find(params[:id])
      end
      
    end
  end
end