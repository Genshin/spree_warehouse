$(document).ready ->
  $('td#destocking_<%= @variant.id %>').html('<%= escape_javascript(render :partial => "destocking_form", :formats => [:html], :handlers => [:erb]) %>')