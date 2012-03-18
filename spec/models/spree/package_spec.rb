require 'spec_helper'

describe Spree::Package do
  context 'validation' do
    it { should have_valid_factory(:package) }
  end
end
