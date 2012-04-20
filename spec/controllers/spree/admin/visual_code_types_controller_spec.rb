require 'spec_helper'

describe Spree::Admin::VisualCodeTypesController do
  before do
    controller.stub :current_user => Factory(:admin_user)
  end

  context ":edit" do
    let(:vct) do
      Factory(:barcode)
    end
    
    it "must redirect with a flash message if there is attemp to edit a system VC type" do
      delete :destroy, :id => vct , :use_route => :spree
      response.should redirect_to(spree.admin_visual_code_types_path)
      flash[:notice].should eql("Cannot edit system visual code type!")
    end
  end
  
  context 'GET :index' do 
    it "should be successful" do
      get :index, :use_route => :spree
      response.should be_success
    end
  end
end
