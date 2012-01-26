require 'spec_helper'

describe Spree::VisualCode do
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:type) }
end
