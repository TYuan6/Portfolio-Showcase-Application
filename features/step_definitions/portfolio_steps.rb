
#The user associated with the emails in the table must exist before calling this
When /the following groups exist:/ do |groups_table|
    groups_table.hashes.each do |group|
       user = User.find_by_email(group[:user_email])
       user.groups << Group.new(:name => group[:name], :description => group[:description])
    end
end

#The user associated with the emails in the table and the groups associated with the group names must exist before calling this
When /the following projects exist:/ do |projects_table| 
    projects_table.hashes.each do |project|
       newProj = Proj.new(:name => project[:name], :description => project[:description], :impact => project[:impact], :begin_date => project[:begin_date], :end_date => project[:end_date])
       user1 = User.find_by_email(project[:user_email])
       group = User.find_by_email(project[:user_email]).groups.find_by_name(project[:group])
       user1.projs << newProj
       group.projs << newProj
    end
end

When /I am on the Portfolio List page/ do
   visit portfolios_path 
end

When /I am on the Create New Portfolio page/ do
    visit new_portfolio_path
end

Then /I see only the following projects displayed:/ do |projects_table|
    found_all_projects = true
    #First see if can find all of the projects in the table
    projects_table.hashes.each do |project| 
        found_it = false
        all("tr").each do |tr|
            if tr.has_content?(project[:name])# && tr.has_content?(project[:description])
               found_it = true
            end
        end
        if found_it == false
           found_all_projects = false 
        end
    end
    
    #Now see if those are the only projects displayed
    #First count the number of groups in the projects to figure out how many heading rows we will have
    groups = []
    projects_table.hashes.each do |project|
        if groups.include?(project[:group]) == false
           groups << project[:group] 
        end
    end
    
    number_of_projects_on_page = all("tr").size() - groups.size()
    number_of_projects = projects_table.hashes.size()
    
    expect((number_of_projects == number_of_projects_on_page) && found_all_projects).to be_truthy
end

When /I select the following portfolio properties:/ do |portfolio_properties|
    portfolio_properties.hashes.each do |portfolio_property|
        fill_in "Name", :with => portfolio_property[:name]
        fill_in "Description", :with => portfolio_property[:description]
    end
end

#Only works if the two users don't have the same project names
And /^I select projects: "(.*?)"$/ do |arg1|
    project_list = arg1.split(', ')
    project_list.each do |project|
        proj_id = Proj.all.find_by_name(project).id
        check("projects[#{proj_id}]")
    end
end

Then /I see only the following portfolios on the page: "(.*?)"$/ do |arg1|
    portfolio_list = arg1.split(', ')
    found_all_portfolios = true
    portfolio_list.each do |portfolio|
        found_it = false
        all('tr').each do |tr|
            if tr.has_content?(portfolio)
               found_it = true
            end
        end
        if found_it == false
           found_all_portfolios = false 
        end
    end
    no_extras = (all('tr').size() - 1) == portfolio_list.size()
    
    expect(found_all_portfolios && no_extras).to be_truthy
end

When /the following portfolios exist:/ do |portfolio_table|
    portfolio_table.hashes.each do |portfolio|
        user = User.find_by_email(portfolio[:user_email])
        new_portfolio = Portfolio.create(:name => portfolio[:name], :description => portfolio[:description])
        user.portfolios << new_portfolio
        user.projs.each do |project|
           new_portfolio.projs << project 
        end
        user.groups.each do |group|
           new_portfolio.groups << group 
        end
        user.projs.each do |project|
            temp_proj_css = ProjCss.where(proj_id: project.id, portfolio_id: new_portfolio.id).take
            if project.name == portfolio[:project_1]
                temp_proj_css.visible = portfolio[:p1_visible] == "true"
            elsif project.name == portfolio[:project_2]
                temp_proj_css.visible = portfolio[:p2_visible] == "true"
            elsif project.name == portfolio[:project_3]
                temp_proj_css.visible = portfolio[:p3_visible] == "true"
            else
                temp_proj_css.visible = portfolio[:p4_visible] == "true"
            end
            temp_proj_css.save
        end
    end
end

When(/^I click "([^"]*)" for portfolio "([^"]*)"$/) do |link_name, portfolio_name|
    all("tr").each do |tr|
        if tr.has_content?(portfolio_name) then
            tr.click_link(link_name)
        end
    end
end

Then(/^I see a portfolio with name "([^"]*)", description "([^"]*)", and only the following projects: "(.*?)"$/) do |port_name, port_description, projects|
    project_list = projects.split(", ")
    correct_name = page.has_content?(port_name)
    correct_description = page.has_content?(port_description)
    
    found_all_projects = true
    project_list.each do |project|
        found_it = false
        all('tbody tr').each do |tr|
            if tr.has_content?(project)
               found_it = true
            end
        end
        if found_it == false
           found_all_projects = false 
        end
    end
    no_extras = (all('tbody tr').size()) == project_list.size()
    
    expect(correct_name && correct_description && found_all_projects && no_extras).to be_truthy
    
end

And /^I set the portfolio to random/ do 
    check("portfolio_randomStyle")
end

And /^I select the template "(.*?)"/ do |arg1|
    choose("portfolio_template_#{arg1}")
end
