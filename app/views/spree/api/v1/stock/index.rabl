node(:count) { @stock_records.count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }

child(@stock_records) do
  attributes *stock_attributes
end