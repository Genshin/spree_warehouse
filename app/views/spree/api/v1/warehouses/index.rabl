object false
node(:count) { @warehouses.count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }
child(@warehouses) do
  extends "spree/api/v1/warehouses/show"
end