require 'spec_helper'

module Spree
  describe Spree::Api::V1::WarehousesController do
    render_views

    let(:warehouse)  { Factory(:warehouse, :name => 'Subaru Warehouse') }
    let(:attributes) { [:id, :name, :code, :location, :details] }

    before do
      stub_authentication!
    end

    context "as a normal user" do
      it "gets all warehouses" do
        api_get :index

        puts json_response.to_json
        json_response.should have_attributes(attributes)
        response.status.should == 200
      end
    end

  end
end