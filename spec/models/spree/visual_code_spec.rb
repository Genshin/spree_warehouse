require 'spec_helper'

describe Spree::VisualCode do
  it { should validate_presence_of(:code) }
  it { should belong_to(:visual_code_type) }
  #it { Factory(:visual_code).should validate_uniqueness_of(:code) }

end
