module Spree
  module Admin
    class VisualCodeTypesController < ResourceController
      
      before_filter :restrict, :except => [:index, :show]
      
      def restrict
        @visual_code_type = VisualCodeType.find(params[:id])
        unless @visual_code_type.can_delete?
          respond_to do |format|
            format.html { redirect_to admin_visual_code_types_url, :notice => 'Cannot edit system visual code type!' }
            format.json { render :text => 'Cannot edit system visual code type!' }
          end
        end
      end
      
      def index
        @visual_code_types = VisualCodeType.all
        respond_to do |format|
          format.html
          format.json { render :json => [:admin, @visual_code_types] }
        end
      end

      def show
        @visual_code_type = VisualCodeType.find(params[:id])
        respond_to do |format|
          format.html
        end
      end
      
      def new
        @visual_code_type = VisualCodeType.new
        respond_to do |format|
          format.html 
          format.json { render :json => [:admin, @visual_code_type] }
        end
      end


      def edit
        @visual_code_type = VisualCodeType.find(params[:id])
      end

      def create
        @visual_code_type = VisualCodeType.new(params[:visual_code_type])

        respond_to do |format|
          if @visual_code_type.save
            format.html { redirect_to admin_visual_code_types_url, :notice => 'Visual Code type was successfully created.' }
            format.json { render :json => [:admin, @visual_code_type], :status => :created, :location => @visual_code_type }
          else
            format.html { render :action => "new" }
            format.json { render :json => [:admin, @visual_code_type.errors], :status => :unprocessable_entity }
          end
        end
      end

      def update
        @visual_code_type = VisualCodeType.find(params[:id])

        respond_to do |format|
          if @visual_code_type.update_attributes(params[:visual_code_type])
            format.html { redirect_to admin_visual_code_types_url, :notice => 'Visual Code Type was successfully updated.' }
            format.json { head :ok }
          else
            format.html { render :action => "edit" }
            format.json { render :json => [:admin, @visual_code_type.errors], :status => :unprocessable_entity }
          end
        end
      end

      def destroy
        @visual_code_type = VisualCodeType.find(params[:id])
        @visual_code_type.destroy

        respond_to do |format|
          format.html { redirect_to admin_visual_code_types_url }
        end
      end
      
    end
  end
end
