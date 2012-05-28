require 'spec_helper'

describe Spree::Admin::StockController do

  let(:product) { Factory(:product, :name => 'Subaru Outback') }

  before do
    controller.stub :current_user => Factory(:admin_user)
    Spree::Config.set :track_inventory_levels => true 
    c_taxonomy = Factory(:container_taxonomy, :name => 'Rack#1') 
    @ct_shelve = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Shelve#1') 
    product.master.count_on_hand = 100
    product.master.reload
  end

  describe "GET :index" do
    it "should be successful" do
      get :index, :use_route => :spree
      response.should be_success
    end
  end

  describe "POST :restock" do
    it "should create a variant_container_taxon after restock" do
      product.master.count_on_hand.should eql(0)
      post :restock, :stock_record => { :variant_id => product.master.id, :container_taxon_id => @ct_shelve.id, :quantity => 50, :direction => 'in'}, :use_route => :spree
      response.should redirect_to(spree.admin_stock_path)
      flash[:notice].should_not be_nil

      product.reload
      product.master.count_on_hand.should eql(50)
      product.master.variant_container_taxons.count.should eql(1)
      product.master.variant_container_taxons.active.count.should eql(1)
    end

    it "should not allow to restock without a variant" do
      post :restock, :stock_record => { :container_taxon_id => @ct_shelve.id, :quantity => 50, :direction => 'in'}, :use_route => :spree
      flash[:error].should eql("Could not restock, no variant selected")
    end

  end

  

  describe "POST :destock" do

    before do 
      product.master.count_on_hand.should eql(0)
      post :restock, :stock_record => { :variant_id => product.master.id, :container_taxon_id => @ct_shelve.id, :quantity => 100, :direction => 'in'}, :use_route => :spree

      product.reload
      product.master.variant_container_taxons.active.count.should eql(1)
      product.master.variant_container_taxons.deactivated.count.should eql(0)
      product.master.count_on_hand.should eql(100)
    end

    it "should change 'activated/deactivated' variant_container_taxon" do 
      post :destock, :stock_record => { :variant_id => product.master.id, :container_taxon_id => @ct_shelve.id, :quantity => 100, :direction => 'out'}, :use_route => :spree
      response.should redirect_to(spree.admin_stock_path)
      flash[:notice].should_not be_nil
      product.reload
      product.master.variant_container_taxons.count.should eql(1)
      product.master.variant_container_taxons.active.count.should eql(0)
      product.master.variant_container_taxons.deactivated.count.should eql(1)
      product.master.count_on_hand.should eql(0)

      post :restock, :stock_record => { :variant_id => product.master.id, :container_taxon_id => @ct_shelve.id, :quantity => 100, :direction => 'in'}, :use_route => :spree

      product.reload
      product.master.variant_container_taxons.count.should eql(1)
      product.master.variant_container_taxons.active.count.should eql(1)
      product.master.variant_container_taxons.deactivated.count.should eql(0)
      product.master.count_on_hand.should eql(100)
    end

    it "should not allow to destock without a variant" do
      post :destock, :stock_record => { :container_taxon_id => @ct_shelve.id, :quantity => 100, :direction => 'out'}, :use_route => :spree
      flash[:error].should eql("Could not destock, no variant selected")
    end
  end

end  