require 'spec_helper'

module Spree
  describe Spree::Api::V1::StockController do
    render_views

    let!(:product) { Factory(:product) }
    let!(:attributes) { [:id, :quantity] }
    let!(:stock_record) { Factory(:stock_record, :quantity => 7) }

    before do
      stub_authentication!
    end

    context "as a normal user" do
      it "retrieves a list of stock" do
        api_get :index
        json_response.first.should have_attributes(attributes)
        response.status.should == 200
      end

      it "gets a single stock record" do
        api_get :show, :id => stock_record.to_param
        json_response.should have_attributes(attributes)
        json_response["stock_record"]["quantity"].should eql(7)
      end
      
    end

    context "as an admin" do
      sign_in_as_admin!

      it "can create a new stock record" do
        api_post :create, :stock_record => { :quantity => 7 }
        json_response.should have_attributes(attributes)
        json_response["stock_record"]["quantity"].should eql(7)
        response.status.should == 201
      end

    end
  
  end
end