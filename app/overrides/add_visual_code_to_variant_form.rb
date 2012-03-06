Deface::Override.new(:virtual_path => "spree/admin/variants/_form",
                      :name => "add_spree_warehouse_visual_codes_to_variant_form",
                      :insert_bottom => "[data-hook='on_hand']",
                      :partial => "spree/admin/variants/bar_code_field.erb")