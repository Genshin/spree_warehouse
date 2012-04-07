module Spree
  module Admin 
    InventoryUnitsController.class_eval do 
      
      before_filter :load_inventory_unit , :only => [:fire]
      respond_to :html

      def fire
        if @iu.send("#{params[:e]}")
          if @iu.shipment.state == 'picked'
            flash.notice = t(:shipment_is_picked)
          else
            flash.notice = t(:unit_picked)
          end
          
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