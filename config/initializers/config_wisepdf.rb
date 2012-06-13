require 'wisepdf'

Wisepdf::Configuration.configure do |c|
  c.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
  c.options = {
    :layout => "layout.html",
    :use_xserver => true,
    :footer => { 
      :right => "#{Date.today.year}",
      :font_size => 8,
      :spacing => 8
    },
    :margin => {
      :bottom => 15
    }
  }

end