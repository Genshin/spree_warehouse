require 'spec_helper'

describe "Destocking Reasons" do
  before(:each) do
    visit spree.admin_path
    sign_in_as!(Factory(:admin_user))
    click_link "Configuration"
  end

  context "admin visiting destocking reasons list" do
    it "should display the existing destocking reasons" do
      Factory(:destocking_reason, :name => "destock", :description => "For stock going outside")
      click_link "Destocking Reasons"
      page.should have_content("Destocking Reasons")
      find('table#destocking_reasons_list tbody tr td:nth-child(1)').text.should == "destock"
      find('table#destocking_reasons_list tbody tr td:nth-child(2)').text.should == "For stock going outside"
    end
  end

  context "admin creating new destocking reason" do
    before(:each) do
      click_link "Destocking Reasons"
      click_link "admin_new_destocking_reason_link"
    end

    it "should be able to create new destocking reason" do
      page.should have_content("New Destocking Reason")
      fill_in "destocking_reason_name", :with => "transfer"
      fill_in "destocking_reason_description", :with => "For transferred stock"
      click_button "Create"
      page.should have_content("successfully created!")
    end

    it "should show validation errors if there are any" do
      click_button "Create"
      page.should have_content("Name can't be blank")
    end
  end
  
  
  context "admin editing a destocking reason" do
    it "should be able to update an existing destocking reason" do
      Factory(:destocking_reason)
      click_link "Destocking Reasons"
      within(:css, 'table#destocking_reasons_list tbody tr:nth-child(1)') { click_link "Edit" }
      fill_in "destocking_reason_description", :with => "desc 99"
      click_button "Update"
      page.should have_content("successfully updated!")
      page.should have_content("desc 99")
    end
  end
end