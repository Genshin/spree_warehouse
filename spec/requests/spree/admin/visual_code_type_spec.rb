require 'spec_helper'

describe Spree::VisualCodeType do
  before (:each) do
    sign_in_as!(Factory(:admin_user))
    Spree::Ability.register_ability(AbilityDecorator)

    @visual_code_type1 = Factory(:visual_code_type, :name => "QR Code")
    
    #visit spree.admin_path
    visit "admin/visual_code_types"
  end

  #TODO turn this into admin/visual_codes/types ?
  context "GET /admin/visual_code_types" do
    it "should list visual code types" do
      within("table#visual_code_types") do
        page.should have_content("QR Code")
      end
    end
  end

end
