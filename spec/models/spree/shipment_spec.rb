require 'spec_helper'

describe Spree::Shipment do
  before(:each) do
    reset_spree_preferences
  end
  
  let(:order) { mock_model Spree::Order, :backordered? => false, :completed? => false}
  let(:shipping_method) { mock_model Spree::ShippingMethod, :calculator => mock('calculator') }
  let(:shipment) { Spree::Shipment.new :order => order, :state => 'pending', :shipping_method => shipping_method }
  let(:charge) { mock_model Spree::Adjustment, :amount => 10, :source => shipment }

  context 'validation' do
    it { should have_valid_factory(:shipment) }
    it { should have_many :packages}
  end
end
