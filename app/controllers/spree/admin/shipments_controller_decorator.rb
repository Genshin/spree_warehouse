module Spree
  module Admin
    ShipmentsController.class_eval do 
      
      before_filter :load_order
      before_filter :load_shipment, :only => [:destroy, :edit, :update, :fire, :create_package]
      before_filter :load_shipping_methods, :except => [:country_changed, :index, :create_package]
      
      def create_package
        @package = @shipment.packages.build
        @package.save
        flash[:notice] = flash_message_for(@package, :successfully_created)
        
        respond_with(@object) do |format|
          format.html { redirect_to edit_admin_order_shipment_path(@order.number, @shipment.number) }
        end
      end
      
      private
      
      def build_shipment
        @shipment = @order.shipments.build
        @shipment.address ||= @order.ship_address
        @shipment.address ||= Address.new(:country_id => Spree::Config[:default_country_id])
        @shipment.master_package ||= @shipment.packages.build
        @shipment.master_package.save
        @shipment.shipping_method ||= @order.shipping_method
        @shipment.attributes = params[:shipment]
      end
    end
  end
end