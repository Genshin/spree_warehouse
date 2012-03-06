Then /^async show me the page$/ do
  wait_until { page.evaluate_script("jQuery.active === 0") }
  Then %Q{show me the page}
end

Then /^async$/ do
  wait_until { page.evaluate_script("jQuery.active === 0") }
end