require 'spec_helper'

module Spree
  describe Spree::Api::V1::StockController do
    render_views

    let(:product) { Factory(:product, :name => 'Subaru Impreza') }
    let!(:attributes) { [:id, :quantity, :container_taxon_id, :direction] }
    let!(:stock_record) { Factory(:stock_record, :quantity => 7) }
    let(:destocking_reason) { Factory(:destocking_reason) }

    before do
      stub_authentication!
      c_taxonomy = Factory(:container_taxonomy, :name => 'Rack#1') 
      @ct_shelve = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Shelve#1') 
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
        api_post :create, :stock_record => { :quantity => 7, :variant_id => product.master.id, 
            :container_taxon_id => @ct_shelve.id, :direction => 'in', :destocking_reason_id => destocking_reason.id,
            :order_number => "123"  }

        json_response.should have_attributes(attributes)
        json_response["stock_record"]["quantity"].should eql(7)
        json_response["stock_record"]["variant_id"].should eql(product.master.id)
        json_response["stock_record"]["container_taxon_id"].should eql(@ct_shelve.id)
        json_response["stock_record"]["direction"].should eql("in")
        json_response["stock_record"]["destocking_reason_id"].should eql(destocking_reason.id)
        response.status.should == 201
      end

    end
  
  end
end