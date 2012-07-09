require 'spec_helper'

module Spree
  describe Spree::Api::V1::ShipmentsController do
    render_views
  
    let(:order) { mock_model Spree::Order, :backordered? => false }
    let(:shipping_method) { mock_model Spree::ShippingMethod, :calculator => mock('calculator') }
    let(:shipment) do
      shipment = Spree::Shipment.new :order => order, :shipping_method => shipping_method
      shipment.state = 'pending'
      shipment
    end

    before do
      stub_authentication!
    end

    context "as a normal user" do
      pending "gets picking_list" do
        api_get :picking_list, :order_id => order.id

        puts json_response.to_json
        #json_response.should have_attributes(attributes)
        response.status.should == 200
      end
    end

  end
end