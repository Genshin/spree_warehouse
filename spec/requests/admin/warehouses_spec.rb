require 'spec_helper'

describe 'Warehouses' do
  before(:each) do
    sign_in_as!(Factory(:admin_user))

    @warehouse1 = Factory(:warehouse, :name => 'huge_warehouse_1')
    Factory(:warehouse, :name => 'huge_warehouse_2')
    @container_taxonomy1 = Factory(:container_taxonomy, :name => "A1")
    @container_taxonomy2 = Factory(:container_taxonomy, :name => "A2")
 
    visit spree.admin_path
    click_link "Warehouses"
  end

  context "listing warehouses" do
    it "should list existing warehouses" do
      page.should have_css('table#warehouses')
      within("table#warehouses") do
        page.should have_content("huge_warehouse_1")
        page.should have_content("huge_warehouse_2")
      end
    end
  end
  
  context "adding new warehouse" do 
    before(:each) do 
      click_link "New Warehouse"
    end 

    it "you should be redirected to warehouses/new view when you hit new warehouse button" do
      fake = Faker::Name.name
      page.should have_css('div#admin_warehouse_new_form')
      fill_in "warehouse_name", :with => fake
      click_button "Create"
      page.should have_content("has been successfully created!")
    end

    it "should give an error if name is not unique" do
      fill_in "warehouse_name" , :with => @warehouse1.name
      click_button "Create"
      page.should have_css('span.field_with_errors')
      page.should have_content("has already been taken")
    end
  end

  context "editing warehouse" do 
    before :each do 
      within('table.index tr:nth-child(2)') { click_link "Edit" }
    end

    it "should allow to edit a warehouse" do 
      page.should have_content("Editing Warehouse")
      fill_in "warehouse_name", :with => "Subaru"
      fill_in "warehouse_code", :with => "12345"
      fill_in "warehouse_location", :with => "Japan"
      fill_in "warehouse_details", :with => "Details"

      checkbox = find('#warehouse_container_taxonomy_ids_')
      checkbox.should_not be_checked
      check "warehouse_container_taxonomy_ids_"

      click_button "Update"
      page.should have_content("successfully updated")
      page.should have_content("A1")
       
      #TODO Check for unique checkbox id
      click_link "Edit"
      checkbox = find('#warehouse_container_taxonomy_ids_')
      checkbox.should be_checked
    end
  end

end