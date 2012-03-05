Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "spree_warehouse_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs']",
                      :text => "<%= tab :warehouses , :visual_code_types, :visual_codes, :container_taxonomies %>")
