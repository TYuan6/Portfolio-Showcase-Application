Given /the users exist:/ do |users_table|
    users_table.hashes.each do |user|
        user = User.new(:email => user[:email], :password => user[:password], :password_confirmation => user[:password], :first_name => user[:first_name], :last_name => user[:last_name], :street => user[:street], :city => user[:city], :state => user[:state], :zipcode => user[:zipcode], :phone => user[:phone], :user_type => user[:user_type])
        user.save!
    end
end

#unused method currently, will probably need later
#When /^User with email "(.*?)" is confirmed$/ do |email|
#    user = User.where(email: email).take
#    user.skip_confirmation!
#end

When /^I sign in email "(.*?)" and password "(.*?)"$/ do |email, password|
    visit new_user_session_path
    fill_in "user_email", :with => email
    fill_in "user_password", :with => password
    click_button 'Log in'
end

When /^I create a new valid user$/ do
    visit new_user_registration_path
    email = ('a'..'z').to_a.shuffle[0,8].join
    email = email + "@test.com"
    fill_in "user_email", :with => email
    fill_in "user_password", :with => "Asdfasdf1"
    fill_in "user_password_confirmation", :with => "Asdfasdf1"
    fill_in "user_first_name", :with => "first_name"
    fill_in "user_last_name", :with => "last_name"
    fill_in "user_street", :with => "street"
    fill_in "user_city", :with => "city"
    select "Iowa", :from => "user_state"
    fill_in "user_zipcode", :with => "12345"
    fill_in "user_phone", :with => "1231231231"
    click_button 'Sign up'
end

When /^I create user with email "(.*?)"$/ do |email|
    visit new_user_registration_path
    fill_in "user_email", :with => email
    fill_in "user_password", :with => "Asdfasdf1"
    fill_in "user_password_confirmation", :with => "Asdfasdf1"
    fill_in "user_first_name", :with => "first_name"
    fill_in "user_last_name", :with => "last_name"
    fill_in "user_street", :with => "street"
    fill_in "user_city", :with => "city"
    select "Iowa", :from => "user_state"
    fill_in "user_zipcode", :with => "12345"
    fill_in "user_phone", :with => "1231231231"
    click_button 'Sign up'
end

When /^I create user with mismatched passwords$/ do 
    visit new_user_registration_path
    email = ('a'..'z').to_a.shuffle[0,8].join
    email = email + "@test.com"
    fill_in "user_email", :with => email
    fill_in "user_password", :with => "Asdfasdf1"
    fill_in "user_password_confirmation", :with => "Asdfasdf2"
    fill_in "user_first_name", :with => "first_name"
    fill_in "user_last_name", :with => "last_name"
    fill_in "user_street", :with => "street"
    fill_in "user_city", :with => "city"
    select "Iowa", :from => "user_state"    
    fill_in "user_zipcode", :with => "12345"
    fill_in "user_phone", :with => "1231231231"
    click_button 'Sign up'
end

When /^I edit my name to "(.*?)" for default user$/ do |name|
    visit edit_user_registration_path
    fill_in "user_first_name", :with => name
    fill_in "user_current_password", :with => "Asdfasdf1"
    click_button 'Update'
end

When /^I edit my name to "(.*?)" for default user with no password$/ do |name|
    visit edit_user_registration_path
    fill_in "user_first_name", :with => name
    click_button 'Update'
end

