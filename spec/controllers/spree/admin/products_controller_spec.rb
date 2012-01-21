require 'spec_helper'

describe Spree::Admin::ProductsController do
  before do
    controller.stub :current_user => Factory(:admin_user)
  end

  context "#index" do


  end
end
