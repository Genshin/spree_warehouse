module Spree
  module Admin
    UsersController.class_eval do 
      def generate_qr_code
      	respond_to do |format|
          format.html
          format.svg { render :qrcode => request.url, :level => :l, :unit => 10 }
          format.png { render :qrcode => request.url }
        end

      end
  	end
  end
end