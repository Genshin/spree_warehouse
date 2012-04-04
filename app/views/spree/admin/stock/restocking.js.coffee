$(document).ready ->
  $('td#restocking_<%= @variant.id %>').html('<%= escape_javascript(render :partial => "restocking_form", :formats => [:html], :handlers => [:erb]) %>')