require 'spec_helper'

module Spree
  describe Spree::Api::V1::StockController do
    render_views

    let!(:product) { create(:product) }
    let(:attributes) { [:id, :name, :quantity] }
    let!(:stock_record) { create(:stock_record) }

    before do
      stub_authentication!
    end

    context "as a normal user" do
      it "retrieves a list of stock" do
        api_get :index
        json_response["stock_records"].first.should have_attributes(attributes)
        json_response["count"].should == 1
        json_response["current_page"].should == 1
        json_response["pages"].should == 1
      end
    end
  
  end
end