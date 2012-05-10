require "rqrcode"

module Spree
  module Admin
    UsersController.class_eval do 
      def generate_qr_code
        code = {profile: {server: "", port: 80, key: Spree::User.find(params[:id]).api_key}}
        @qr = RQRCode::QRCode.new(code.to_json, :size => 10, :level => :h)

      	respond_to do |format|
          format.html { render :partial => "spree/admin/users/generate_qr_code" }
        end

      end
  	end
  end
end
