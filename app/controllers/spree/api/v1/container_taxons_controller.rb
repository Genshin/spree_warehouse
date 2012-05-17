module Spree
  module Api
    module V1
      class ContainerTaxonsController < Spree::Api::V1::BaseController
        def index
          @container_taxons = container_taxonomy.root.children
        end

        def show
          @container_taxon = container_taxon
        end

        def create
          authorize! :create, ContainerTaxon
          @container_taxon = ContainerTaxon.new(params[:container_taxon])
          if @container_taxon.save
            render :show, :status => 201
          else
            invalid_resource!(@container_taxon)
          end
        end

        def update
          authorize! :update, container_taxon
          if container_taxon.update_attributes(params[:container_taxon])
            render :show, :status => 200
          else
            invalid_resource!(container_taxon)
          end
        end

        def destroy
          authorize! :delete, container_taxon
          container_taxon.destroy
          render :text => nil, :status => 200
        end

        private

        def container_taxonomy
          @container_taxonomy ||= ContainerTaxonomy.find(params[:container_taxonomy_id])
        end

        def container_taxon
          @container_taxon ||= container_taxonomy.container_taxons.find(params[:id])
        end

      end
    end
  end
end