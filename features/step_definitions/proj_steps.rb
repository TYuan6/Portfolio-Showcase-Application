Given /^I am on the Projects List page$/ do
  visit projs_path
end

When /^I have clicked "(.*?)"$/ do |link|
  click_on link
end

When /^I create a new project with name "(.*?)" and http web link "(.*?)"$/ do |project_name, web_link|
  fill_in "proj_name", :with => project_name
  fill_in "Description:", :with => "Description1"
  fill_in "Impact:", :with => "impace content"
  fill_in "Keywords:", :with => "important"
  fill_in "Http Web Link:", :with => web_link
  click_button "Create Project"
end

Then /^I should see the listing projects including name "(.*?)"$/ do |project_name|
  result=false
  all("tr").each do |tr|
    if tr.has_content?(project_name)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

When /^I have clicked the link "(.*?)" of a project named "(.*?)"/ do |link, project_name|
  all("tr").each do |tr|
    if tr.has_content?(project_name)
      within(tr) do
        click_link link
      end
      break
    end
  end
end

Then /^I should see page "(.*?)" with project name "(.*?)"$/ do |page_title, project_name|
  result = page.has_content?(page_title) && find_field("proj_name").value == project_name
  expect(result).to be_truthy
end

When /^I have modified text_field of "(.*?)" with new content "(.*?)"$/ do |field_name, content|
  fill_in field_name, :with => content
end

Then /^I should see content "(.*?)" in text_field of "(.*?)"$/ do |content, field_name|
  result = find_field(field_name).value == content
  expect(result).to be_truthy
end

Then /^I should see project "(.*?)" disappears$/ do |project_name|
  project_exist=false
  all("tr").each do |tr|
    within(tr) do
      if tr.has_content?(project_name)
        project_exist = true
        break
      end
    end
  end
  expect(project_exist).to be_falsey
end
