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
          @taxon = Taxon.new(params[:taxon])
          if @taxon.save
            render :show, :status => 201
          else
            invalid_resource!(@taxon)
          end
        end

        def update
          authorize! :update, Taxon
          if taxon.update_attributes(params[:taxon])
            render :show, :status => 200
          else
            invalid_resource!(taxon)
          end
        end

        def destroy
          authorize! :delete, Taxon
          taxon.destroy
          render :text => nil, :status => 200
        end

        private

        def taxonomy
          @taxonomy ||= Taxonomy.find(params[:taxonomy_id])
        end

        def taxon
          @taxon ||= taxonomy.taxons.find(params[:id])
        end

      end
    end
  end
end