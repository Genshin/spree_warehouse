module Spree
  module Api
    module V1
      VariantsController.class_eval do
      	def search
          @variants = scope.includes(:option_values).scoped.search(params[:q]).result.page(params[:page])
          render :index
        end
      end
    end
  end
end