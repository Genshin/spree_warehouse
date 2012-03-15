require 'spec_helper'

describe Spree::PackageLineItem do 
  context 'validation' do 
    it { should have_valid_factory(:package_line_item) }
  end
end
