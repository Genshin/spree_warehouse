require 'spec_helper'

describe "Warehouses" do
  before(:each) do
    @user = Factory(:admin_user)
    #sign_in_as!(Factory(:admin_user, :email => "c@example.com"))
    visit spree.admin_path
  end

  context "listing products" do
    it "should list existing warehouses" do
      Factory(:warehouse, :name => 'huge_warehouse_1')
      Factory(:warehouse, :name => 'huge_warehouse_2')

      click_link "Warehouses"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }

      click_link "admin_products_listing_name_title"
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
    end
  end
end
