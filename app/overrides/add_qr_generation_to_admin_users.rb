Deface::Override.new(:virtual_path => "spree/admin/users/_form",
                     :name => "auth_admin_user_qr",
                     :insert_after => "[data-hook='admin_user_edit_form'], #admin_user_edit_form[data-hook]",
                     :partial => "spree/admin/users/qr")