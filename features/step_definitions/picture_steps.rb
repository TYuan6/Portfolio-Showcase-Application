Given /^I am on the Picture Listing page of project "(.*?)"$/ do |project_name|
  visit projs_path
  click_on "Add new project"
  fill_in "proj_name", :with => project_name
  fill_in "Description:", :with => "Description1"
  fill_in "Impact:", :with => "impace content"
  fill_in "Keywords:", :with => "important"
  click_button "Create Project"
  all("tr").each do |tr|
    if tr.has_content?(project_name)
      within(tr) do
        click_link "Pictures"
      end
      break
    end
  end
end

#picture_link: ./features/testPic.jpg
When /^I upload a new picture with link "(.*?)"$/ do |picture_link|
  attach_file('picture_project_img', picture_link)
  click_button "Upload"
end

Then /^I should see the listing pictures$/ do
  row=0
  all("tr").each do |tr|
     row = row+1;
  end
  expect(row).to equal(2)
end

When /^I have clicked the link "(.*?)" in the "(.*?)"th row of pictures management table$/ do |link, lineIndex|
  row = -1
  lineIndex = lineIndex.to_s.to_d
  all("tr").each do |tr|
    row = row+1
    next if row != lineIndex
    within(tr) do
        click_link link
    end
  end
end

Then /^I should see page "(.*?)" in picuters management$/ do |page_title|
  result = page.has_content?(page_title)
  expect(result).to be_truthy
end

Then /^I should see picture remains "(.*?)"$/ do |remainNum|
  pictures_num=-1
  remainNum = remainNum.to_s.to_d
  all("tr").each do |tr|
    pictures_num = pictures_num +1
  end
  pictures_num.should == remainNum
end