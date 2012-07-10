node(:count) { @restocked_items.count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }

child(@restocked_items) do
  attributes *restocked_items_attributes
end