require 'spec_helper'

describe Spree::InventoryUnit do
  context 'validation' do
    it { should have_valid_factory(:inventory_unit) }
    it { should belong_to :package }
  end
end