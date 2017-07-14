And /^I view portfolio "(.*?)"$/ do |arg1|
    visit portfolio_group_csses_show_path(Portfolio.where(:name => arg1).first.id)
end

And /^I view group "(.*?)" for portfolio "(.*?)"$/ do |arg1, arg2|
    visit portfolio_group_csses_show_path(Portfolio.where(:name => arg2).first.id)
    click_button arg1
end

And /^For a project css I check "(.*?)" visible for "(.*?)"$/ do |arg1, arg2|
    cssId = ProjCss.where(:proj_id => Proj.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg2).first.id).first.id
    check("portfolio_proj_csses#{cssId}_visible")
end

And /^For a project css I uncheck "(.*?)" visible for "(.*?)"$/ do |arg1, arg2|
    cssId = ProjCss.where(:proj_id => Proj.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg2).first.id).first.id
    uncheck("portfolio_proj_csses#{cssId}_visible")
end

And /^For a project css I check "(.*?)" background for "(.*?)"$/ do |arg1, arg2|
    cssId = ProjCss.where(:proj_id => Proj.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg2).first.id).first.id
    check("portfolio_proj_csses#{cssId}_background")
end

And /^For a project css I uncheck "(.*?)" background for "(.*?)"$/ do |arg1, arg2|
    cssId = ProjCss.where(:proj_id => Proj.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg2).first.id).first.id
    uncheck("portfolio_proj_csses#{cssId}_background")
end

And /^For a project css I set "(.*?)" "(.*?)" to "(.*?)" for "(.*?)"$/ do |arg1, arg2, arg3, arg4|
    cssId = ProjCss.where(:proj_id => Proj.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg4).first.id).first.id
    arg2 = arg2.camelize(:lower)
    arg2.delete!(" ")
    select arg3, :from => "portfolio_proj_csses#{cssId}_#{arg2}"
end

And /^For a project css I input "(.*?)" "(.*?)" to "(.*?)" for "(.*?)"$/ do |arg1, arg2, arg3, arg4|
    cssId = ProjCss.where(:proj_id => Proj.where(:name => arg1).first.id, :portfolio_id => Portfolio.where(:name => arg4).first.id).first.id
    arg2 = arg2.camelize(:lower)
    arg2.delete!(" ")
    fill_in "portfolio_proj_csses#{cssId}_#{arg2}", :with => arg3
end

When(/^I am editing css styles for "(.*?)"$/) do |group_name|
    link_name = "Edit Styling"
    portfolio_name = "Portfolio 1"
    all("tr").each do |tr|
        if tr.has_content?(portfolio_name) then
            tr.click_link(link_name)
        end
    end
    click_button group_name
    
end


When(/^I see defaultStyle is in the acceptable values for project 1$/) do 
    expect(find_field("portfolio_proj_csses1_defaultStyle").value).to be_in(ProjCss.all_defaults_check)
end

When(/^I see position is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_position").value).to eq("static")
end

When(/^I see width is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_width").value).to eq("")
end

When(/^I see height is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_height").value).to eq("")
end

When(/^I see top is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_top").value).to eq("0")
end

When(/^I see left is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_left").value).to eq("0")
end        

When(/^I see font type is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_font").value).to be_in(ProjCss.all_fonts_check)
end        

When(/^I see opacity is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_opacity").value).to eq("1.0")
end 
        
When(/^I see border radius is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_borderRadius").value).to be_in((2..5).to_a.to_s)
end 
        
When(/^I see border size is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_borderSize").value).to be_in((4..8).to_a.to_s)
end 
        
When(/^I see box shadow is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_boxShadow").value).to be_in(ProjCss.all_shadows_check)
end 
        
When(/^I see hover is in the acceptable values for project 1/) do 
    expect(find_field("portfolio_proj_csses1_hover").value).to be_in(ProjCss.all_hovers_check)
end 
   
   
Then(/^I save and check updates carry over to show views$/) do
    style = find_field("portfolio_proj_csses1_defaultStyle").value
    shadow = find_field("portfolio_proj_csses1_boxShadow").value
    hover = find_field("portfolio_proj_csses1_hover").value
    click_button "Update Styling"
    visit portfolio_proj_csses_show_path(1, 1)
    expect(page.body =~ /#{style}/m).to be_truthy
    expect(page.body =~ /#{shadow}/m).to be_truthy
    expect(page.body =~ /#{hover}/m).to be_truthy
end         

Then(/^I save and then check updates carry over to show views for "(.*?)" projs/) do |arg1|
    style = find_field("portfolio_proj_csses1_defaultStyle").value
    shadow = find_field("portfolio_proj_csses1_boxShadow").value
    hover = find_field("portfolio_proj_csses1_hover").value
    click_button "Update Styling"
    var = 1;
    port = Portfolio.where(:name => arg1).first
    port.token = var
    port.save
    visit myportfolio_project_link_path(var.to_s+".1?")
    expect(page.body =~ /#{style}/m).to be_truthy
    expect(page.body =~ /#{shadow}/m).to be_truthy
    expect(page.body =~ /#{hover}/m).to be_truthy
end    

Then(/^I am viewing show projects for Group 1$/) do
    visit portfolio_proj_csses_show_path(1, 1)
end      

Then(/^I am viewing shared show projects for Group 1$/) do
    var = 1;
    port = Portfolio.where(:name => "Portfolio 1").first
    port.token = var
    port.save
    visit myportfolio_project_link_path(var.to_s+".1?")
end      

When(/^I select "(.*?)" to copy style from$/) do |arg1 |
    select arg1, :from => "portfolio_portfolio_style"
end


Then(/^I am viewing shared show projects for "(.*?)" "(.*?)"$/) do |group,port|
    var = 1;
    port = Portfolio.where(:name => port).first
    port.token = var
    port.save
    visit myportfolio_project_link_path(var.to_s+".1?")
end      
