require 'spec_helper'

describe Spree::PackageInventoryUnit do
  context 'validation' do
    it { should have_valid_factory(:package_inventory_unit) }
    it { should belong_to :package }
    it { should belong_to :inventory_unit }
  end
end
