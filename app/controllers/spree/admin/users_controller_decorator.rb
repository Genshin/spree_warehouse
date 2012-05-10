require "rqrcode"

module Spree
  module Admin
    UsersController.class_eval do 
      def generate_qr_code
        user = Spree::User.find(params[:id])
        code = {profile: {name: user.email, server: request.host, port: request.port, key: user.api_key}}
        @qr = RQRCode::QRCode.new(code.to_json, :size => 10, :level => :m)

      	respond_to do |format|
          format.html { render :partial => "spree/admin/users/generate_qr_code" }
        end

      end
  	end
  end
end
