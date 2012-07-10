require 'spec_helper'

module Spree
  describe Spree::Api::V1::ShipmentsController do
    render_views 

    before do
      #TODO Clean this
      Spree::Zone.delete_all
      Spree::ShippingMethod.delete_all

      @order = Factory(:completed_order_with_totals, :number => "R100", :state => "complete")   
      @shipping_method = Factory(:shipping_method, :zone => Factory(:zone, :name => 'North America'))
      @shipment = Factory(:shipment, :order => @order, :shipping_method => @shipping_method, :inventory_units => @order.inventory_units )
      @order.inventory_units.each do |iu|
        iu.update_attribute_without_callbacks('state', 'sold')
      end
      @shipment.state = 'sold'

    end

    before do
      stub_authentication!
    end

    context "as a normal user" do
      pending "gets picking_list" do
        api_get :picking_list, :order_id => @order.id
        puts json_response.to_json
        response.status.should == 200
      end

      pending "should mark shipment as picked if all inventory units are picked" do
        @shipment.state.should == 'sold'
        @order.inventory_units.each do |iu|
          iu.update_attribute('state', 'picked')
        end
        @order.reload
        puts @order.inventory_units.to_json
        puts @shipment.to_json
        @shipment.state.should == 'picked'

      end
    end

  end
end