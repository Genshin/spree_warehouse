require 'spec_helper'

describe Spree::VisualCodeType do
  it { should validate_presence_of(:name) }
  #it { Factory(:visual_code_type).should validate_uniqueness_of(:name) }
end
