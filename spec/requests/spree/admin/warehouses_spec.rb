require 'spec_helper'

describe "Warehouses" do
  before(:each) do
    user = Factory(:admin_user, :email => "admin@person.com", :password => "password", :password_confirmation => "password")
    Spree::Ability.register_ability(AbilityDecorator)
    
    visit spree.login_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "Login"
    
    visit spree.admin_path
  end

  context "listing warehouses" do
    it "should list existing warehouses" do
      Factory(:warehouse, :name => 'huge_warehouse_1')
      Factory(:warehouse, :name => 'huge_warehouse_2')
      click_link "Warehouses"
      #TODO make real check
    end
  end
end
