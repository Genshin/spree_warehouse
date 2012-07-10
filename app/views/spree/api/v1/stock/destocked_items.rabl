node(:count) { @destocked_items.count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }

child(@destocked_items) do
  attributes *destocked_items_attributes
end