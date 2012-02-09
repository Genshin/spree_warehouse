require 'spec_helper'

describe Spree::VisualCode do
  before (:each) do
    sign_in_as!(Factory(:admin_user))

    #need types to check against
    @visual_code_type_qr = Spree::VisualCodeType.find_or_create_by_name({:name => "QR Code", :handler => "qrcode"})
    @visual_code_type_bar = Spree::VisualCodeType.find_or_create_by_name({:name => "BarCode", :handler => "barcode"})

    @visual_code1 = Spree::VisualCode.create(:code => "99954321", :type => Spree::VisualCodeType.where(:name => "BarCode"))
    @visual_code2 = Spree::VisualCode.create(:code => "[TEST] QR Code Data 1234 テスト　試 ★ test", :type => Spree::VisualCodeType.where({:name => "QR Code", :handler => "qrcode"}))
    
    visit spree.admin_path
    click_link "Warehouses"
    click_link "Visual Codes"
  end

  #TODO turn this into admin/visual_codes/types ?
  context "GET /admin/visual_codes" do
    it "should list visual codes" do
      within("table#visual_codes") do
        page.should have_content("99954321")
        page.should have_content("QR Code")
        page.should have_content("BarCode")
      end
    end
  end

end
