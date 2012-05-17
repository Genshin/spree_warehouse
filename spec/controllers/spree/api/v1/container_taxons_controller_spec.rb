require 'spec_helper'

module Spree
  describe Api::V1::ContainerTaxonsController do
    render_views

    let(:container_taxonomy) { Factory(:container_taxonomy) }
    let(:container_taxon) { Factory(:container_taxon, :name => "Ruby", :container_taxonomy => container_taxonomy) }
    let(:container_taxon2) { Factory(:container_taxon, :name => "Rails", :container_taxonomy => container_taxonomy) }
    let(:attributes) { ["id", "name", "permalink", "position", "parent_id", "container_taxonomy_id"] }

    before do
      stub_authentication!
      container_taxon2.children << create(:container_taxon, :name => "3.2.2", :container_taxonomy => container_taxonomy)
      container_taxon.children << container_taxon2
      container_taxonomy.root.children << container_taxon
    end

    context "as a normal user" do
      it "gets all container_taxons" do
        api_get :index, :container_taxonomy_id => container_taxonomy.id

        json_response.first['container_taxon']['name'].should eq container_taxon.name
        children = json_response.first['container_taxon']['container_taxons']
        children.count.should eq 1
        children.first['container_taxon']['name'].should eq container_taxon2.name
        children.first['container_taxon']['container_taxons'].count.should eq 1
      end

      it "gets a single container_taxon" do
        api_get :show, :id => container_taxon.id, :container_taxonomy_id => container_taxonomy.id

        json_response['container_taxon']['name'].should eq container_taxon.name
        json_response['container_taxon']['container_taxons'].count.should eq 1
      end

      it "can learn how to create a new container_taxon" do
        api_get :new, :container_taxonomy_id => container_taxonomy.id
        json_response["attributes"].should == attributes.map(&:to_s)
        required_attributes = json_response["required_attributes"]
        required_attributes.should include("name")
      end

      it "cannot create a new container_taxon if not an admin" do
        api_post :create, :container_taxonomy_id => container_taxonomy.id, :container_taxon => { :name => "Location" }
        assert_unauthorized!
      end

      it "cannot update a container_taxon" do
        api_put :update, :container_taxonomy_id => container_taxonomy.id, :id => container_taxon.id, :container_taxon => { :name => "I hacked your store!" }
        assert_unauthorized!
      end

      it "cannot delete a container_taxon" do
        api_delete :destroy, :container_taxonomy_id => container_taxonomy.id, :id => container_taxon.id
        assert_unauthorized!
      end
    end

    context "as an admin" do
      sign_in_as_admin!

      it "can create" do
        api_post :create, :container_taxonomy_id => container_taxonomy.id, :container_taxon => { :name => "Colors", :parent_id => container_taxon.id}
        json_response.should have_attributes(attributes)
        response.status.should == 201

        container_taxon.reload.children.count.should eq 2
      end

      it "cannot create a new container_taxon with invalid attributes" do
        api_post :create, :container_taxonomy_id => container_taxonomy.id, :container_taxon => {}
        response.status.should == 422
        json_response["error"].should == "Invalid resource. Please fix errors and try again."
        errors = json_response["errors"]

        container_taxon.reload.children.count.should eq 1
      end
    end

  end
end