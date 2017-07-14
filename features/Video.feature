Feature: Video Management

  Background:
    Given the users exist:
      | email         | password | first_name | last_name | street | city | state | zipcode | phone      |
      | eric@eric.com | Ff123456 | first_name | last_name | street | city | IA    | 12345   | 1231231231 |
    And the following groups exist:
      | user_email    | name    | description      | picture |
      | eric@eric.com | Group 1 | eric@eric.com g1 | none    |
    And I sign in email "eric@eric.com" and password "Ff123456"
    And I am on the Video Listing page of project "ProjectForPictureTest"

  Scenario: Upload a new video
    When I have clicked "New Video"
    And I upload a new video with link "https://www.youtube.com/watch?v=N1wQCJpIP5o"
    Then I should see the listing videos

  Scenario: Show a video
    When I have clicked "New Video"
    And I upload a new video with link "https://www.youtube.com/watch?v=N1wQCJpIP5o"
    And I have clicked the link "Show" in the "1"th row of video management table
    Then I should see page "video1" in video management

  Scenario: Delete a existing video
    When I have clicked "New Video"
    And I upload a new video with link "https://www.youtube.com/watch?v=N1wQCJpIP5o"
    And I have clicked the link "Destroy" in the "1"th row of video management table
    Then I should see video remains "0"
    
  Scenario: Delete a existing video from 2 pictures list
    When I have clicked "New Video"
    And I upload a new video with link "https://www.youtube.com/watch?v=N1wQCJpIP5o"
    And I have clicked "New Video"
    And I upload a new video with link "https://www.youtube.com/watch?v=N1wQCJpIP5O"
    And I have clicked the link "Destroy" in the "2"th row of video management table
    Then I should see video remains "1"