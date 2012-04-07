Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                      :name => "spree_destocking_reasons_tab",
                      :insert_bottom => "[data-hook='admin_configurations_menu']",
                      :text => "<tr><td><%= link_to t(:destocking_reasons), admin_destocking_reasons_path %></td><td><%= t(:destocking_reasons_description) %></td></tr>")