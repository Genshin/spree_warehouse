require 'spec_helper'

describe "Destocked items" do
  before(:each) do
    product1 = Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-01 01:01:01', :sku => "A100")
    product2 = Factory(:product, :name => 'zomg shirt', :available_on => '2011-01-01 01:01:01', :sku => "Z100")

    c_taxonomy = Factory(:container_taxonomy, :name => 'Rack#1') 
    ct_shelve = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Shelve#1') 
    ct_container = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Container#1', :parent_id => ct_shelve) 
  
    Factory(:stock_record, :variant => product1.master, :container_taxon => ct_shelve, :quantity => 5, :direction => 'out')
    Factory(:stock_record, :variant => product2.master, :container_taxon => ct_container, :quantity => 10, :direction => 'out')

    sign_in_as!(Factory(:admin_user))
    visit spree.admin_path

    click_link "Stock"
    click_link "Destocked Items"
  end

  context "destocked items list" do
    it "should list and sort existing destocked items" do
      
      #FIXME must check the default sorting
      #destocked_before.asc
      #within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      #within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }

      #destocked_before.desc
      click_link "admin_destocked_items_destocked_before"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }

      #container_taxon.asc
      click_link "admin_destocked_items_container_taxon"
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(2)') { page.should have_content("Container#1") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("Shelve#1") }

      #container_taxon.desc
      click_link "admin_destocked_items_container_taxon"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(2)') { page.should have_content("Shelve#1") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("Container#1") }

      #variant_product_name.asc
      click_link "admin_destocked_items_product_name"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
       
      #variant_product_name.desc
      click_link "admin_destocked_items_product_name"
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }

      #TODO Add count_on_hand to product, so to check for positive values
      #on_hand.asc
      click_link "admin_destocked_items_on_hand"
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(2)') { page.should have_content("-10") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("-5") }


      #on_hand.desc
      click_link "admin_destocked_items_on_hand"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(2)') { page.should have_content("-5") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("-10") }


      #quantity.asc
      click_link "admin_destocked_items_quantity"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(2)') { page.should have_content("5") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(3)') { page.should have_content("10") }

      #quantity.desc
      click_link "admin_destocked_items_quantity"
      within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      within('table.index tr:nth-child(2)') { page.should have_content("10") }
      within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("5") } 

    end
  end

  context "searching destocked items" do
    it "should be able to search destocked items by product name, sku and container taxon" do

      fill_in "q_variant_product_name_cont", :with => "ap"
      click_button "Search"
      page.should have_content("apache baseball cap")
      page.should_not have_content("zomg shirt")

      fill_in "q_variant_sku_cont", :with => "A1"
      click_button "Search"
      page.should have_content("apache baseball cap")
      page.should_not have_content("zomg shirt")

      fill_in "q_container_taxon_name_cont", :with => "Shelve"
      click_button "Search"
      page.should have_content("apache baseball cap")
      page.should_not have_content("zomg shirt")

    end
  end 
end