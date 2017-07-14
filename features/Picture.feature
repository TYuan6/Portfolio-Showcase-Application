Feature: Picture Management

  Background:
    Given the users exist:
      | email         | password | first_name | last_name | street | city | state | zipcode | phone      |
      | eric@eric.com | Ff123456 | first_name | last_name | street | city | IA    | 12345   | 1231231231 |
    And the following groups exist:
      | user_email    | name    | description      | picture |
      | eric@eric.com | Group 1 | eric@eric.com g1 | none    |
    And I sign in email "eric@eric.com" and password "Ff123456"
    And I am on the Picture Listing page of project "ProjectForPictureTest"

  Scenario: Upload a new picture
    When I have clicked "New Picture"
    And I upload a new picture with link "./features/support/testPic.jpeg"
    Then I should see the listing pictures

  Scenario: Show a picture
    When I have clicked "New Picture"
    And I upload a new picture with link "./features/support/testPic.jpeg"
    And I have clicked the link "Show" in the "1"th row of pictures management table
    Then I should see page "Show Picture" in picuters management

  Scenario: Delete a existing picture
    When I have clicked "New Picture"
    And I upload a new picture with link "./features/support/testPic.jpeg"
    And I have clicked the link "Destroy" in the "1"th row of pictures management table
    Then I should see picture remains "0"

  Scenario: Delete a existing picture from 2 pictures list
    When I have clicked "New Picture"
    And I upload a new picture with link "./features/support/testPic.jpeg"
    And I have clicked "New Picture"
    And I upload a new picture with link "./features/support/testPic2.jpeg"
    And I have clicked the link "Destroy" in the "2"th row of pictures management table
    Then I should see picture remains "1"