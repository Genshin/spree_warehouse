require 'spec_helper'

describe "Warehouses" do
  before(:each) do
    sign_in_as!(Factory(:admin_user))
    #user = Factory(:admin_user, :email => "admin@person.com", :password => "password", :password_confirmation => "password")
    Spree::Ability.register_ability(AbilityDecorator)
    
    Factory(:warehouse, :name => 'huge_warehouse_1')
    Factory(:warehouse, :name => 'huge_warehouse_2')

    #visit spree.login_path
    #fill_in "user_email", :with => user.email
    #fill_in "user_password", :with => user.password
    #click_button "Login"
    
    visit spree.admin_path
  end

  context "listing warehouses" do
    it "should list existing warehouses" do

      click_link "Warehouses"
      #TODO make real check
    end
  end
end
