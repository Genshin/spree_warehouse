require 'spec_helper'

describe Spree::VisualCode do
  before (:each) do
    sign_in_as!(Factory(:admin_user))
    Spree::Ability.register_ability(AbilityDecorator)

    #need types to check against
    #@visual_code_type_qr = Factory(:visual_code_type, :name => "QR Code")
    #@visual_code_type_bar = Factory(:visual_code_type, :name => "BarCode")

    #@visual_code1 = Factory(:visual_code, :code => "99954321", :type => Spree::VisualCodeType.where(:name => "Bar Code"))
    #@visual_code2 = Factory(:visual_code_type, :name => "BarCode")
    
    visit spree.admin_path
    click_link "Warehouses"
    click_link "Visual Codes"
  end

  #TODO turn this into admin/visual_codes/types ?
  context "GET /admin/visual_codes" do
    it "should list visual codes" do
    #  within("table#visual_cods") do
    #    page.should have_content("QR Code")
    #    page.should have_content("BarCode")
    #  end
    end
  end

end
