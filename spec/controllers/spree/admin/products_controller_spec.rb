require 'spec_helper'

describe Spree::Admin::ProductsController do

  before do
    controller.stub :current_user => Factory(:admin_user)
  end

  describe "GET :index" do
    it "should be successful" do
      get :index, :use_route => :spree
      response.should be_success
    end
  end 
end
