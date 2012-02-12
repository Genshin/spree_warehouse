require 'spec_helper'

describe Spree::VisualCode do
  before (:each) do
    sign_in_as!(Factory(:admin_user))

    #need types to check against
    @visual_code_type_qr = Factory(:visual_code_type, :name => "QR Code")
    @visual_code_type_bar = Factory(:visual_code_type, :name => "BarCode")

    @visual_code1 = Factory(:visual_code, :code => "99954321", :visual_code_type => @visual_code_type_qr)
    @visual_code2 = Factory(:visual_code, :code => "[TEST] QR Code Data 1234 test", :visual_code_type => @visual_code_type_bar)
    
    visit spree.admin_path
    click_link "Warehouses"
    click_link "Visual Codes"
  end

  context "visual codes" do
    it "should list visual codes" do
      within("table#visual_codes") do
        page.should have_content("99954321")
        page.should have_content("QR Code")
        page.should have_content("BarCode")
      end
    end
  end

end
