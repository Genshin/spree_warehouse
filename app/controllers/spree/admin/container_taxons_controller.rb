module Spree
  module Admin
    class ContainerTaxonsController < BaseController

      respond_to :html, :json, :js


      def generate_pdf
        respond_to do |format|
          format.html { render :layout => false }
          format.pdf { render(:pdf => "container_taxon_pdf", :wkhtmltopdf => '/usr/local/bin/wkhtmltopdf', :layout => "pdf_layout") }
        end
      end

      def index
        @container_taxons = container_taxonomy.root.children
      end

      def show 
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

        @qr = RQRCode::QRCode.new(@code.to_json, :size => 12, :level => :l)
        respond_with(:admin, @container_taxon) 
      end

      def create
        @container_taxonomy = ContainerTaxonomy.find(params[:container_taxonomy_id])
        @container_taxon = @container_taxonomy.container_taxons.build(params[:container_taxon])
        if @container_taxon.save
          respond_with(@container_taxon) do |format|
            format.json {render :json => @container_taxon.to_json }
          end
        else
          flash[:error] = t('errors.messages.could_not_create_container_taxon')
          respond_with(@container_taxon) do |format|
            format.html { redirect_to @container_taxonomy ? edit_admin_container_taxonomy_url(@container_taxonomy) : admin_container_taxonomies_url }
          end
        end
      end

      def edit
        @container_taxonomy = ContainerTaxonomy.find(params[:container_taxonomy_id])
        @container_taxon = @container_taxonomy.container_taxons.find(params[:id])
        @permalink_part = @container_taxon.permalink.split("/").last
      end

      def update
        @container_taxonomy = ContainerTaxonomy.find(params[:container_taxonomy_id])
        @container_taxon = @container_taxonomy.container_taxons.find(params[:id])
        parent_id = params[:container_taxon][:parent_id]
        new_position = params[:container_taxon][:position]

        if parent_id || new_position #container_taxon is being moved
          new_parent = parent_id.nil? ? @container_taxon.parent : ContainerTaxon.find(parent_id.to_i)
          new_position = new_position.nil? ? -1 : new_position.to_i

          # Bellow is a very complicated way of finding where in nested set we
          # should actually move the container_taxon to achieve sane results,
          # JS is giving us the desired position, which was awesome for previous setup,
          # but now it's quite complicated to find where we should put it as we have
          # to differenciate between moving to the same branch, up down and into
          # first position.
          new_siblings = new_parent.children
          if new_position <= 0 && new_siblings.empty?
            @container_taxon.move_to_child_of(new_parent)
          elsif new_parent.id != @container_taxon.parent_id
            if new_position == 0
              @container_taxon.move_to_left_of(new_siblings.first)
            else
              @container_taxon.move_to_right_of(new_siblings[new_position-1])
            end
          elsif new_position < new_siblings.index(@container_taxon)
            @container_taxon.move_to_left_of(new_siblings[new_position]) # we move up
          else
            @container_taxon.move_to_right_of(new_siblings[new_position]) # we move down
          end
          # Reset legacy position, if any extensions still rely on it
          new_parent.children.reload.each{|t| t.update_attribute(:position, t.position)}
      
          if parent_id
            @container_taxon.reload
            @container_taxon.set_permalink
            @container_taxon.save!
            @update_children = true
          end
        end

        if params.key? "permalink_part"
          parent_permalink = @container_taxon.permalink.split("/")[0...-1].join("/")
          parent_permalink += "/" unless parent_permalink.blank?
          params[:container_taxon][:permalink] = parent_permalink + params[:permalink_part]
        end
        #check if we need to rename child container_taxons if parent name or permalink changes
        @update_children = true if params[:container_taxon][:name] != @container_taxon.name || params[:container_taxon][:permalink] != @container_taxon.permalink

        if @container_taxon.update_attributes(params[:taxon])
          flash.notice = flash_message_for(@container_taxon, :successfully_updated)
        end

        #rename child container_taxons
        if @update_children
          @container_taxon.descendants.each do |container_taxon|
            container_taxon.reload
            container_taxon.set_permalink
            container_taxon.save!
          end
        end
    
        respond_with(@container_taxon) do |format|
          format.html {redirect_to edit_admin_container_taxonomy_url(@container_taxonomy) }
          format.json {render :json => @container_taxon.to_json }
        end
      end

      def destroy
        @container_taxon = ContainerTaxon.find(params[:id])
        @container_taxon.destroy
        respond_with(@container_taxon) { |format| format.json { render :json => '' } }
      end

      private

      def container_taxonomy
        @container_taxonomy ||= ContainerTaxonomy.find(params[:container_taxonomy_id])
      end
      
      
=begin
      def selected
        @product = load_product
        @container_taxons = @product.container_taxons

        respond_with(:admin, @container_taxons)
      end

      def available
        @product = load_product
        @container_taxons = params[:q].blank? ? [] : ContainerTaxon.where('lower(name) LIKE ?', "%#{params[:q].mb_chars.downcase}%")
        @container_taxons.delete_if { |container_taxon| @product.container_taxons.include?(container_taxon) }

        respond_with(:admin, @container_taxons)
      end

      def remove
        @product = load_product
        @container_taxon = ContainerTaxon.find(params[:id])
        @product.container_taxons.delete(@container_taxon)
        @product.save
        @container_taxons = @product.container_taxons

        respond_with(@container_taxon) { |format| format.js { render_js_for_destroy } }
      end

      def select
        @product = load_product
        @container_taxon = ContainerTaxon.find(params[:id])
        @product.container_taxons << @container_taxon
        @product.save
        @container_taxons = @product.container_taxons

        respond_with(:admin, @container_taxons)
      end

      def batch_select
        @product = load_product
        @container_taxons = params[:container_taxon_ids].map{|id| ContainerTaxon.find(id)}.compact
        @product.container_taxons = @container_taxons
        @product.save
        redirect_to selected_admin_product_container_taxons_url(@product)
      end

      private

      def load_product
        Product.find_by_permalink! params[:product_id]
      end
=end
    end
  end
end