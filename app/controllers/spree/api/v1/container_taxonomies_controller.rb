module Spree
  module Api
    module V1
      class ContainerTaxonomiesController < Spree::Api::V1::BaseController
        def index
          @container_taxonomies = ContainerTaxonomy.order('name').includes(:root => :children)
        end

        def show
          @container_taxonomy = ContainerTaxonomy.find(params[:id])
        end

        def create
          authorize! :create, ContainerTaxonomy
          @container_taxonomy = ContainerTaxonomy.new(params[:container_taxonomy])
          if @container_taxonomy.save
            render :show, :status => 201
          else
            invalid_resource!(@container_taxonomy)
          end
        end

        def update
          authorize! :update, ContainerTaxonomy
          if container_taxonomy.update_attributes(params[:container_taxonomy])
            render :show, :status => 200
          else
            invalid_resource!(container_taxonomy)
          end
        end

        def destroy
          authorize! :delete, ContainerTaxonomy
          container_taxonomy.destroy
          render :text => nil, :status => 200
        end

        private

        def container_taxonomy
          @container_taxonomy ||= ContainerTaxonomy.find(params[:id])
        end

      end
    end
  end
end