module Spree
  module Admin
    module QrHelper
      def qr_code
        @container_taxonomy = ContainerTaxonomy.find(params[:container_taxonomy_id])
        @container_taxon = ContainerTaxon.find(params[:id])

        @code = { :container_taxon => { 
                      :name => @container_taxon.name, 
                      :permalink => @container_taxon.permalink,
                      :updated_at => @container_taxon.updated_at,
                      :container_taxonomy => {  :id =>    @container_taxonomy.id,
                                                :name =>  @container_taxonomy.name 
                                              }, 

                      :warehouses =>         {  :id => @container_taxonomy.warehouses.map(&:id).join(' '),
                                                :name => @container_taxonomy.warehouses.map(&:name).join(' ')
                                             } 
                  } 
                }
      end
    end
  end
end