module Spree
  module Admin
    class ContainerTaxonomiesController < ResourceController
      respond_to :json, :only => [:get_children]

      def get_children
        @container_taxons = ContainerTaxon.find(params[:parent_id]).children

        respond_with(@container_taxons)
      end

      private

      def location_after_save
        if @container_taxonomy.created_at == @container_taxonomy.updated_at
          edit_admin_container_taxonomy_url(@container_taxonomy)
        else
          admin_container_taxonomies_url
        end
      end
    end
  end
end