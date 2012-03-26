module Spree
  module Admin
    ShipmentsController.class_eval do 
      
      before_filter :load_order
      before_filter :load_shipment, :only => [:destroy, :edit, :update, :fire, :create_package, :picked]
      before_filter :load_shipping_methods, :except => [:country_changed, :index, :picking_list, :create_package]
      
      def create_package
        @package = @shipment.packages.build
        @package.save
        flash[:notice] = flash_message_for(@package, :successfully_created)
        
        respond_with(@object) do |format|
          format.html { redirect_to edit_admin_order_shipment_path(@order.number, @shipment.number) }
        end
      end
      
      def assign_inventory_units
        unless params[:inventory_units].nil? 
          return unless params[:inventory_units].has_key? :ids
          assign_packages_to_inventory_units
          @shipment.inventory_unit_ids = params[:inventory_units][:ids].keys
        end
      end
      
      def picking_list
        @shipments = @order.shipments
        respond_with(@shipments)
      end
      

      private
      
      def assign_packages_to_inventory_units
        params[:inventory_units][:packages].each do |iu_id,package_id|
          @inventory_unit = InventoryUnit.find(iu_id)
          @inventory_unit.package = Package.find(package_id)
          @inventory_unit.save
        end
      end
      
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