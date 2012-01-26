#Seeds for Warehouse extension

visual_code_seeds = [{:name => "Barcode", :handler => "barcode"},
    {:name => "QR Code", :handler => "qrcode"}]

visual_code_seeds.each do |vcs|
  Spree::VisualCodeType.find_or_create_by_name(vcs)
end
