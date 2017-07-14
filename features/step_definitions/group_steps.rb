When /^I create a new group "(.*?)"$/ do |name|
    visit new_group_path
    
    fill_in "group_name", :with => name
    fill_in "group_description", :with => "Description test"
    

    click_button 'Create Group'
end


When /^I edit a existing group name to "(.*?)"$/ do |arg|

    fill_in "group_name", :with => arg
    click_button 'Save Changes'
end

