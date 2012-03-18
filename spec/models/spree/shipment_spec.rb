require 'spec_helper'

describe Spree::Shipment do
  context 'validation' do
    it { should have_valid_factory(:shipment) }
    it { should have_many :packages}
  end
end
