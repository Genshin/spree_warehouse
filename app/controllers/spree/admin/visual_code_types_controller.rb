module Spree
  module Admin
    class VisualCodeTypesController < BaseController
      respond_to :html, :json, :xml

      def index
        @visual_code_types = VisualCodeType.all
        respond_to do |format|
          format.html
          format.xml  { render :xml => @visual_cpde_types}
          format.json { render :json => @visual_code_types}
        end
      end

      def new
        @visual_code_type = VisualCodeType.new
      end

      def create
        @visual_code_type = VisualCodeType.new(params[:visual_code_type])
        
        respond_to do |format|
          if @visual_code_type.save
#TODO
          else
            format.html { render :action => 'new' }
          end
        end
      end

      def show
      end

      def edit
      end

    end
  end
end
