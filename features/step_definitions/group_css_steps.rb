When /these following groups exist:/ do |groups_table|
    groups_table.hashes.each do |group|
       user = User.find_by_email(group[:user_email])
       user.groups << Group.new(:name => group[:name], :description => group[:description])
    end
end

And /^I check "(.*?)" visible for "(.*?)"$/ do |arg1, arg2|
    cssId = GroupCss.where(:group_id => Group.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg2).first.id).first.id
    check("portfolio_group_csses#{cssId}_visible")
end

And /^I uncheck "(.*?)" visible for "(.*?)"$/ do |arg1, arg2|
    cssId = GroupCss.where(:group_id => Group.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg2).first.id).first.id
    uncheck("portfolio_group_csses#{cssId}_visible")
end

And /^I check "(.*?)" background for "(.*?)"$/ do |arg1, arg2|
    cssId = GroupCss.where(:group_id => Group.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg2).first.id).first.id
    check("portfolio_group_csses#{cssId}_background")
end

And /^I uncheck "(.*?)" background for "(.*?)"$/ do |arg1, arg2|
    cssId = GroupCss.where(:group_id => Group.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg2).first.id).first.id
    uncheck("portfolio_group_csses#{cssId}_background")
end

And /^I set "(.*?)" "(.*?)" to "(.*?)" for "(.*?)"$/ do |arg1, arg2, arg3, arg4|
    cssId = GroupCss.where(:group_id => Group.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg4).first.id).first.id
    arg2 = arg2.camelize(:lower)
    arg2.delete!(" ")
    select arg3, :from => "portfolio_group_csses#{cssId}_#{arg2}"
end

And /^I input "(.*?)" "(.*?)" to "(.*?)" for "(.*?)"$/ do |arg1, arg2, arg3, arg4|
    cssId = GroupCss.where(:group_id => Group.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg4).first.id).first.id
    arg2 = arg2.camelize(:lower)
    arg2.delete!(" ")
    fill_in "portfolio_group_csses#{cssId}_#{arg2}", :with => arg3
end


When(/^I see defaultStyle is in the acceptable values for group 1$/) do 
    expect(find_field("portfolio_group_csses1_defaultStyle").value).to be_in(GroupCss.all_defaults_check)
end

When(/^I see position is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_position").value).to eq("static")
end

When(/^I see width is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_width").value).to eq("")
end

When(/^I see height is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_height").value).to eq("")
end

When(/^I see top is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_top").value).to eq("0")
end

When(/^I see left is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_left").value).to eq("0")
end        

When(/^I see font type is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_font").value).to be_in(GroupCss.all_fonts_check)
end        

When(/^I see opacity is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_opacity").value).to eq("1.0")
end 
        
When(/^I see border radius is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_borderRadius").value).to be_in((2..5).to_a.to_s)
end 
        
When(/^I see border size is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_borderSize").value).to be_in((4..8).to_a.to_s)
end 
        
When(/^I see box shadow is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_boxShadow").value).to be_in(GroupCss.all_shadows_check)
end 
        
When(/^I see hover is in the acceptable values for group 1/) do 
    expect(find_field("portfolio_group_csses1_hover").value).to be_in(GroupCss.all_hovers_check)
end 

Then(/^I save and check updates carry over to show views for groups$/) do 
    style = find_field("portfolio_group_csses1_defaultStyle").value
    shadow = find_field("portfolio_group_csses1_boxShadow").value
    hover = find_field("portfolio_group_csses1_hover").value
    click_button "Update Styling"
    visit portfolio_group_csses_show_path(1)
    expect(page.body =~ /#{style}/m).to be_truthy
    expect(page.body =~ /#{shadow}/m).to be_truthy
    expect(page.body =~ /#{hover}/m).to be_truthy
end         

Then(/^I save and check updates carry over to show views for "(.*?)"/) do |arg1|
    style = find_field("portfolio_group_csses1_defaultStyle").value
    shadow = find_field("portfolio_group_csses1_boxShadow").value
    hover = find_field("portfolio_group_csses1_hover").value
    click_button "Update Styling"
    var = 1;
    port = Portfolio.where(:name => arg1).first
    port.token = var
    port.save
    visit myportfolio_group_link_path(var)
    expect(page.body =~ /#{style}/m).to be_truthy
    expect(page.body =~ /#{shadow}/m).to be_truthy
    expect(page.body =~ /#{hover}/m).to be_truthy
end         

Then(/^I am viewing show groups for Group 1$/) do 
    visit portfolio_group_csses_show_path(1)
end       

Then(/^I am viewing shared show groups for Group 1/) do
    var = 1;
    port = Portfolio.where(:name => "Portfolio 1").first
    port.token = var
    port.save
    visit myportfolio_group_link_path(var)
end       

Then(/^I am viewing shared show groups for "(.*?)"/) do |arg|
    var = 1;
    port = Portfolio.where(:name => arg).first
    port.token = var
    port.save
    visit myportfolio_group_link_path(var)
end       
