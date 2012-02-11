require 'spec_helper'

describe Spree::VisualCodeType do
  before (:each) do
    sign_in_as!(Factory(:admin_user))
    Spree::Ability.register_ability(AbilityDecorator)

    @visual_code_type_qr = Factory(:visual_code_type, :name => "QR Code")
    @visual_code_type_bar = Factory(:visual_code_type, :name => "BarCode")
    
    visit spree.admin_path
    click_link "Warehouses"
    click_link "Visual Codes"
    click_link "Visual Code Types"
    #visit "admin/visual_code_types"
  end

  #TODO turn this into admin/visual_codes/types ?
  context "GET /admin/visual_codes/types" do
    it "should list visual code types" do
      within("table#visual_code_types") do
        page.should have_content("QR Code")
        page.should have_content("BarCode")
      end
    end
  end

end
