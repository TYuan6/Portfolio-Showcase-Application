Given /^I am on the home page$/ do
    visit pages_home_path
end

When /^I click link "(.*?)"$/ do |link|
    click_link link
end

When /^I click button "(.*?)"$/ do |button|
    click_button button
end

When /^I go to "(.*?)"$/ do |path|
    visit path
end

Then /^I see "(.*?)" on the page$/ do |arg|
    expect(page.body =~ /#{arg}/m).to be_truthy
end

Then /^I see "(.*?)" checked on the page$/ do |arg|
    expect(find_field("portfolio_template_#{arg}")).to be_checked
end

Then /^I dont see "(.*?)" on the page$/ do |arg|
    expect(!(page.body =~ /#{arg}/m)).to be_truthy
end

Given /^I am on the page for creating a new group$/ do
    visit new_group_path
end

When /^print$/ do
    puts page.body
end