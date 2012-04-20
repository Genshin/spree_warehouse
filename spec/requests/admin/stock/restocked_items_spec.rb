require 'spec_helper'

describe "Restocked items" do
  before(:each) do
    sign_in_as!(Factory(:admin_user))
    visit spree.admin_path
  end

  context "restocked items list" do
    it "should list existing destocked items" do
      product1 = Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-06 18:21:13:', :count_on_hand => '0')
      product2 = Factory(:product, :name => 'zomg shirt', :available_on => '2125-01-06 18:21:13', :count_on_hand => '5')
      Factory(:stock_record, :variant => product1.master, :quantity => 5, :direction => 'in')
      Factory(:stock_record, :variant => product2.master, :quantity => 10, :direction => 'in')

      click_link "Stock"
      click_link "Restocked Items"
      
      #restocked_before.asc
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }

      #restocked_before.desc
      click_link "admin_restocked_items_restocked_before"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
      
      #variant_product_name.asc
      click_link "admin_restocked_items_product_name"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
       
      #variant_product_name.desc
      click_link "admin_restocked_items_product_name"
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }

      #on_hand.asc
      click_link "admin_restocked_items_on_hand"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(2)') { page.should have_content("5") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("10") }

      #on_hand.desc
      click_link "admin_restocked_items_on_hand"
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(2)') { page.should have_content("10") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("5") }

      #quantity.asc
      click_link "admin_restocked_items_quantity"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(2)') { page.should have_content("5") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("10") }

      #quantity.desc
      click_link "admin_restocked_items_quantity"
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(2)') { page.should have_content("10") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("5") }

      
    end
  end

  context "searching restocked items" do
    it "should be able to search restocked items by product name, sku and container taxon " do
      product1 = Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-01 01:01:01', :sku => "A100")
      product2 = Factory(:product, :name => 'apache baseball cap2', :available_on => '2011-01-01 01:01:01', :sku => "B100")
      product3 = Factory(:product, :name => 'zomg shirt', :available_on => '2011-01-01 01:01:01', :sku => "Z100")
  
      Factory(:stock_record, :variant => product1.master, :quantity => 5, :direction => 'in')
      Factory(:stock_record, :variant => product2.master, :quantity => 5, :direction => 'in')
      Factory(:stock_record, :variant => product3.master, :quantity => 5, :direction => 'in')

      #Spree::Product.update_all :count_on_hand => 10

      click_link "Stock"
      click_link "Restocked Items"

      fill_in "search_variant_product_name_contains", :with => "ap"
      click_button "Search"
      #save_and_open_page
      page.should have_content("apache baseball cap")
      page.should have_content("apache baseball cap2")
      page.should_not have_content("zomg shirt")

      fill_in "search_variant_sku_contains", :with => "A1"
      click_button "Search"
      page.should have_content("apache baseball cap")
      page.should_not have_content("apache baseball cap2")
      page.should_not have_content("zomg shirt")
    end
  end 
end