require 'spec_helper'

module Spree
  describe Spree::Api::V1::StockController do
    render_views

    let(:product) { Factory(:product, :name => 'Subaru Impreza') }
    let(:destocking_reason) { Factory(:destocking_reason) }
    
    let!(:attributes) { [:id, :quantity, :container_taxon_id, :direction] }
    let!(:restocked_items_attributes) { [:id, :quantity, :container_taxon_id, :variant_id, :direction, :order_number, :created_at] }
    let!(:destocked_items_attributes) { [:id, :quantity, :container_taxon_id, :variant_id, :direction, :order_number, :destocking_reason_id,  :created_at] }
    
    let!(:restocked_item_record) { Factory(:stock_record, :quantity => 7, :direction => 'in') }
    let!(:destocked_item_record) { Factory(:stock_record, :quantity => 77, :direction => 'out') }

    before do
      stub_authentication!
      c_taxonomy = Factory(:container_taxonomy, :name => 'Rack#1') 
      @ct_shelve = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Shelve#1') 
    end

    context "as a normal user" do
      it "retrieves a list of stock" do
        api_get :index
        json_response["stock_records"].first.should have_attributes(attributes)
        response.status.should == 200
      end

      it "can search stock" do 
        Factory(:stock_record, :quantity => 3, :order_number => "X001", :direction => 'in') 
        api_get :index , :q => { :order_number_cont => "X0" } 
        json_response["stock_records"].first.should have_attributes(attributes)
        json_response["count"].should == 1
        response.status.should == 200
      end

      it "retrieves a list of restocked items" do
        api_get :restocked_items
        json_response["stock_records"].first.should have_attributes(restocked_items_attributes)
        response.status.should == 200
      end

      it "can search restocked items" do 
        Factory(:stock_record, :quantity => 3, :order_number => "A001", :direction => 'in') 
        api_get :restocked_items , :q => { :order_number_cont => "A0" }  
        json_response["stock_records"].first.should have_attributes(restocked_items_attributes)
        json_response["count"].should == 1
        response.status.should == 200
      end

      it "retrieves a list of destocked items" do
        api_get :destocked_items
        json_response["stock_records"].first.should have_attributes(destocked_items_attributes)
        response.status.should == 200
      end

      it "can search destocked items" do 
        Factory(:stock_record, :quantity => 3, :order_number => "B001", :direction => 'out') 
        api_get :destocked_items , :q => { :order_number_cont => "B0" } 
        json_response["stock_records"].first.should have_attributes(destocked_items_attributes)
        json_response["count"].should == 1
        response.status.should == 200
      end

      it "gets a single stock record" do
        api_get :show, :id => restocked_item_record.to_param
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

      it "can create a new stock record by permalink" do
        api_post :create, :stock_record => { :quantity => 7, :variant_id => product.master.id,
           :direction => 'in', :destocking_reason_id => destocking_reason.id,
           :order_number => "123"  }, :container_taxon => { :permalink => @ct_shelve.permalink }

        json_response.should have_attributes(attributes)
        json_response["stock_record"]["quantity"].should eql(7)
        json_response["stock_record"]["variant_id"].should eql(product.master.id)
        json_response["stock_record"]["container_taxon_id"].should eql(@ct_shelve.id)
        json_response["stock_record"]["direction"].should eql("in")
        json_response["stock_record"]["destocking_reason_id"].should eql(destocking_reason.id)
        response.status.should == 201
      end


      it "can not create a new stock record w/o a variant_id supplied" do
        api_post :create, :stock_record => { :quantity => 7, 
            :container_taxon_id => @ct_shelve.id, :direction => 'in', :destocking_reason_id => destocking_reason.id,
            :order_number => "123"  }
        response.status.should == 422
      end

      it "can not create a new stock record w/o a valid variant" do
        api_post :create, :stock_record => { :quantity => 7, :variant_id => 555,
            :container_taxon_id => @ct_shelve.id, :direction => 'in', :destocking_reason_id => destocking_reason.id,
            :order_number => "123"  }
        response.status.should == 422
      end

    end
  
  end
end