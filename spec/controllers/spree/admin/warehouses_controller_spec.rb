require 'spec_helper'

describe Spree::Admin::WarehousesController do

  before do
    controller.stub :current_user => Factory(:admin_user)
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index, :use_route => :spree
      response.should be_success
    end
  end 

  context "destroying a warehouse" do
    let(:warehouse) do
      warehouse = create(:warehouse)
    end

    it "marks at deleted the warehouse" do
      spree_delete :destroy, :id => warehouse
      warehouse.reload.deleted_at.should_not be_nil
    end
  end

end
