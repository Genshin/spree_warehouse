require 'spec_helper'

describe Spree::Package do
  context 'validation' do
    it { should have_valid_factory(:package) }
    it { should belong_to :shipment }
    it { should belong_to :container_taxon }
    it { should have_many :inventory_units }
  end
    
  let(:order) { mock_model Spree::Order, :backordered? => false }
  let(:shipping_method) { mock_model Spree::ShippingMethod, :calculator => mock('calculator') }
  let(:shipment) { Spree::Shipment.new :order => order, :state => 'pending', :shipping_method => shipping_method }
  let(:package) { Spree::Package.new :shipment => shipment }
  
  context "#generate_tracking_number" do
    it "should generate a random string" do
      package.generate_tracking_number.is_a?(String).should be_true
      (package.generate_tracking_number.to_s.length > 0).should be_true
    end
  end

  context "#create" do
    it "should assign a tracking number" do
      new_package = Spree::Package.create
      new_package.tracking_number.should_not be_nil
    end
  end
end
