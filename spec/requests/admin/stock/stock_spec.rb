require 'spec_helper'

describe "Stock" do
  before(:each) do
    @product1 = Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-01 01:01:01', :sku => "A100")
    
    c_taxonomy = Factory(:container_taxonomy, :name => 'Rack#1') 
    @ct_shelve = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Shelve#1') 
    @ct_container = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Container#1', :parent_id => @ct_shelve)

    Factory(:variant_container_taxon, :quantity => 5, :variant => @product1.master, :container_taxon => @ct_shelve) 

    Factory(:destocking_reason, :name => 'destock')

    sign_in_as!(Factory(:admin_user))
    visit spree.admin_path
  end

  context "searching" do
 
    before do 
      product2 = Factory(:product, :name => 'zomg shirt', :available_on => '2011-01-01 01:01:01', :sku => "Z100")
      product3 = Factory(:product, :name => 'apache baseball cap2', :available_on => '2011-01-01 01:01:01', :sku => "A100")

      Factory(:stock_record, :variant => @product1.master, :container_taxon => @ct_shelve, :quantity => 5, :direction => 'in')
      Factory(:stock_record, :variant => product2.master, :container_taxon => @ct_container, :quantity => 10, :direction => 'in')
      click_link "Stock"
    end

    it "should search by product name" do
      page.should have_content("apache baseball cap")
      page.should have_content("apache baseball cap2")
      page.should have_content("zomg shirt")

      fill_in "q_name_cont", :with => "ap"
      click_button "Search"
      
      page.should have_content("apache baseball cap")
      page.should have_content("apache baseball cap2")
      page.should_not have_content("zomg shirt")
    end

    it "should search by SKU" do
      page.should have_content("apache baseball cap")
      page.should have_content("apache baseball cap2")
      page.should have_content("zomg shirt")

      fill_in "q_variants_including_master_sku_cont", :with => "Z1"
      click_button "Search"

      page.should have_content("zomg shirt")
      page.should_not have_content("apache baseball cap")
      page.should_not have_content("apache baseball cap2")
    end

    it "should search by container_taxon" do
      page.should have_content("apache baseball cap")
      page.should have_content("apache baseball cap2")
      page.should have_content("zomg shirt")

      fill_in "q_variants_including_master_container_taxons_name_cont", :with => "Shelve"
      click_button "Search"

      page.should have_content("apache baseball cap")
      page.should_not have_content("apache baseball cap2")
      page.should_not have_content("zomg shirt")
    end

  end 

  context "restocking and destocking" do

    before do 
      click_link "Stock"
    end

    it "should add new stock" , :js => true do
      click_link 'new_stock_link'
      wait_until { page.find("#new_stock_form") }
      #TODO Continue the spec
    end

    it 'should restock and destock product', :js => true do

      #TODO Refactor in multiple specs

      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(2)') { click_link "Restock" }
      
      fill_in 'stock_record_quantity', :with => 7
      fill_in 'stock_record_order_number', :with => '12345'
      select 'Shelve#1', :from => 'stock_record_container_taxon_id'
      click_button 'Submit'
 
      page.should have_content('successfully restocked')
      page.should have_content('apache baseball cap')
      page.should have_content('Shelve#1')
      page.should have_content('7')

      within('table.index tr:nth-child(2)') { click_link "Destock" }
      fill_in 'stock_record_quantity', :with => 6
      select 'destock', :from => 'stock_record_destocking_reason_id'
      click_button 'Submit'

      page.should have_content('successfully destocked')
      page.should have_content('apache baseball cap')
      page.should have_content('Shelve#1')
      page.should have_content('1')

      click_link 'Restocked Items'
      within('table.index tr:nth-child(2)') {  
                                                page.should have_content('Shelve#1')
                                                page.should have_content('7') #restocked quantity
                                                page.should have_content('12345') #order_number
                                                page.should have_content('A100') #SKU
                                                page.should have_content('apache baseball cap')
                                                page.should have_content('1') #on_hand
                                                page.should have_content('less than a minute')
                                            }

      click_link 'Destocked Items'
      within('table.index tr:nth-child(2)') { 
                                                page.should have_content('Shelve#1')
                                                page.should have_content('6') #restocked quantity
                                                page.should have_content('A100') #SKU
                                                page.should have_content('apache baseball cap')
                                                page.should have_content('1') #on_hand
                                                page.should have_content('less than a minute')
                                            }
    end
  end


end