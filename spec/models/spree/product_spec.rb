require 'spec_helper'

describe Spree::Product do
  before do
    @product = Spree::Product.new(:name => "Foo", :price => 1.99)
  end
  
  context "visual code" do
    it "should save visual code" do
      @product.visual_code = "123456"
      @product.save
      @product.visual_code.should == "123456"
    end
  end
end
