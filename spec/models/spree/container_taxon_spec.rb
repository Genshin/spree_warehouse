# coding: UTF-8

require 'spec_helper'

describe Spree::ContainerTaxon do
  let(:container_taxon) { Spree::ContainerTaxon.new(:name => "Ruby on Rails") }

  context "validation" do
    it { should have_valid_factory(:container_taxon) }
    it { should have_many(:stock) }
  end

  context "set_permalink" do

    it "should set permalink correctly when no parent present" do
      container_taxon.set_permalink
      container_taxon.permalink.should == "ruby-on-rails"
    end

    #TODO Change to Japanese
    it "should support Chinese characters" do
      container_taxon.name = "你好"
      container_taxon.set_permalink
      container_taxon.permalink.should == 'ni-hao'
    end

    context "with parent taxon" do
      before do
        container_taxon.stub(:parent_id => 123)
        Spree::ContainerTaxon.should_receive(:find).with(123).and_return(mock_model(Spree::ContainerTaxon, :permalink => "brands"))
      end

      it "should set permalink correctly when taxon has parent" do
        container_taxon.set_permalink
        container_taxon.permalink.should == "brands/ruby-on-rails"
      end

      it "should set permalink correctly with existing permalink present" do
        container_taxon.permalink = "b/rubyonrails"
        container_taxon.set_permalink
        container_taxon.permalink.should == "brands/rubyonrails"
      end
      
      #TODO Change to Japanese
      it "should support Chinese characters" do
        container_taxon.name = "我"
        container_taxon.set_permalink
        container_taxon.permalink.should == "brands/wo"
      end

    end

  end

end