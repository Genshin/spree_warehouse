require 'spec_helper'

describe Spree::Package do
  context 'validation' do
    it { should have_valid_factory(:package) }
    it { should belong_to :shipment }
    it { should belong_to :container_taxon }
    it { should have_many :inventory_units }
  end
end
