require 'spec_helper'

describe Warehouse do
  it { should validate_presence_of(:name) }
  it { Factory(:warehouse).should validate_uniqueness_of(:name) }
end
