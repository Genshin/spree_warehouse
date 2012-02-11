require 'spec_helper'

describe Spree::VisualCodeType do
  before (:each) do
    sign_in_as!(Factory(:admin_user))
    @visual_code_type_qr = Factory(:visual_code_type, :name => "QR Code")
    @visual_code_type_bar = Factory(:visual_code_type, :name => "BarCode")
    
    visit spree.admin_path
    click_link "Warehouses"
    click_link "Visual Codes"
    click_link "Visual Code Types"
  end

  context "visual code types" do
    it "should list visual code types" do
      within("table#visual_code_types") do
        page.should have_content("QR Code")
        page.should have_content("BarCode")
      end
    end
  end

end
