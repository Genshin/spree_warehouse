Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                      :name => "add_spree_warehouse_visual_codes_to_variant_form",
                      :insert_top => "ul#shipping-specs",
                      :partial => "spree/admin/products/bar_code_field.erb")