Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                      :name => "add_spree_warehouse_visual_codes_to_product_form",
                      :insert_bottom => "[data-hook='admin_product_form_right']",
                      :partial => "spree/admin/products/bar_code_field.erb")