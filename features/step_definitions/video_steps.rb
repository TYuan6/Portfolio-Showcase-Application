Given /^I am on the Video Listing page of project "(.*?)"$/ do |project_name|
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
        click_link "Video"
      end
      break
    end
  end
end


When /^I upload a new video with link "(.*?)"$/ do |link|
  fill_in "video_title", :with => "video1"
  fill_in "video_link", :with => link
  click_button "Submit"
end

Then /^I should see the listing videos/ do
  row=0
  all("tr").each do |tr|
     row = row+1;
  end
  expect(row).to equal(2)
end

When /^I have clicked the link "(.*?)" in the "(.*?)"th row of video management table$/ do |link, lineIndex|
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

Then /^I should see page "(.*?)" in video management$/ do |page_title|
  result = page.has_content?(page_title)
  expect(result).to be_truthy
end

Then /^I should see video remains "(.*?)"$/ do |remainNum|
  pictures_num=-1
  remainNum = remainNum.to_s.to_d
  all("tr").each do |tr|
    pictures_num = pictures_num +1
  end
  pictures_num.should == remainNum
end