require 'spec_helper'

module Spree
  describe Api::V1::ContainerTaxonomiesController do
    render_views

    let(:container_taxonomy) { create(:container_taxonomy) }
    let(:container_taxon) { create(:container_taxon, :name => "Ruby", :container_taxonomy => container_taxonomy) }
    let(:container_taxon2) { create(:container_taxon, :name => "Rails", :container_taxonomy => container_taxonomy) }
    let(:attributes) { [:id, :name] }

    before do
      stub_authentication!
      container_taxon2.children << create(:container_taxon, :name => "3.2.2", :container_taxonomy => container_taxonomy)
      container_taxon.children << container_taxon2
      container_taxonomy.root.children << container_taxon
    end

    context "as a normal user" do
      it "gets all container_taxonomies" do
        api_get :index

        json_response.first['container_taxonomy']['name'].should eq container_taxonomy.name
        json_response.first['container_taxonomy']['root']['container_taxons'].count.should eq 1
      end

      it "gets a single container_taxonomy" do
        api_get :show, :id => container_taxonomy.id

        json_response['container_taxonomy']['name'].should eq container_taxonomy.name

        children = json_response['container_taxonomy']['root']['container_taxons']
        children.count.should eq 1
        children.first['container_taxon']['name'].should eq container_taxon.name
        children.first['container_taxon'].key?('container_taxons').should be_false
      end

      it "gets a single container_taxonomy with set=nested" do
        api_get :show, :id => container_taxonomy.id, :set => 'nested'

        json_response['container_taxonomy']['name'].should eq container_taxonomy.name

        children = json_response['container_taxonomy']['root']['container_taxons']
        children.first['container_taxon'].key?('container_taxons').should be_true
      end

      it "can learn how to create a new container_taxonomy" do
        api_get :new
        json_response["attributes"].should == attributes.map(&:to_s)
        required_attributes = json_response["required_attributes"]
        required_attributes.should include("name")
      end

      it "cannot create a new container_taxonomy if not an admin" do
        api_post :create, :container_taxonomy => { :name => "Location" }
        assert_unauthorized!
      end

      it "cannot update a container_taxonomy" do
        api_put :update, :id => container_taxonomy.id, :container_taxonomy => { :name => "I hacked your store!" }
        assert_unauthorized!
      end

      it "cannot delete a container_taxonomy" do
        api_delete :destroy, :id => container_taxonomy.id
        assert_unauthorized!
      end
    end

    context "as an admin" do
      sign_in_as_admin!

      it "can create" do
        api_post :create, :container_taxonomy => { :name => "Colors"}
        json_response.should have_attributes(attributes)
        response.status.should == 201
      end

      it "cannot create a new container_taxonomy with invalid attributes" do
        api_post :create, :container_taxonomy => {}
        response.status.should == 422
        json_response["error"].should == "Invalid resource. Please fix errors and try again."
        errors = json_response["errors"]
      end
    end

  end
end