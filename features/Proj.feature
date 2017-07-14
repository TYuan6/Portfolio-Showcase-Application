Feature: Projects

  Background:
    Given the users exist:
      | email         | password | first_name | last_name | street | city | state | zipcode | phone      |
      | eric@eric.com | Ff123456 | first_name | last_name | street | city | IA    | 12345   | 1231231231 |
      | eric2@eric.com| Ff123456 | first_name | last_name | street | city | IA    | 12345   | 1231231231 |
      | eric3@eric.com| Ff123456 | first_name | last_name | street | city | IA    | 12345   | 1231231231 |

    And the following groups exist:
      | user_email     | name    | description       | picture |
      | eric@eric.com  | Group 1 | eric@eric.com g1  | none    |

    And I sign in email "eric@eric.com" and password "Ff123456"
    When I am on the Projects List page

  Scenario: Create a new project
    When I have clicked "Add new project"
    And I create a new project with name "StrageProject2" and http web link "http://www.abc.com"
    Then I should see the listing projects including name "StrageProject2"

  Scenario: Show a project
    When I have clicked "Add new project"
    And I create a new project with name "StrageProject2" and http web link "http://www.abc.com"
    And I have clicked the link "Show" of a project named "StrageProject2"
    Then I should see page "Show my Existing Project" with project name "StrageProject2"

  Scenario: Edit a project
    When I have clicked "Add new project"
    And I create a new project with name "StrageProject2" and http web link "http://www.abc.com"
    And I have clicked the link "Edit" of a project named "StrageProject2"
    Then I should see page "Editing Project" with project name "StrageProject2"

  Scenario: Modify description property of a project
    When I have clicked "Add new project"
    And I create a new project with name "StrageProject2" and http web link "http://www.abc.com"
    And I have clicked the link "Edit" of a project named "StrageProject2"
    And I have modified text_field of "Description" with new content "I love this game"
    And I have clicked "Save Changes"
    And I have clicked the link "Edit" of a project named "StrageProject2"
    Then I should see content "I love this game" in text_field of "Description"

  Scenario: Modify web link of a project
    When I have clicked "Add new project"
    And I create a new project with name "StrageProject2" and http web link "http://www.abc.com"
    And I have clicked the link "Edit" of a project named "StrageProject2"
    And I have modified text_field of "Http Web Link" with new content "http://www.foxnews.com"
    And I have clicked "Save Changes"
    And I have clicked the link "Edit" of a project named "StrageProject2"
    Then I should see content "http://www.foxnews.com" in text_field of "Http Web Link"

  Scenario: Delete a existing project
    When I have clicked "Add new project"
    And I create a new project with name "StrageProject2" and http web link "http://www.abc.com"
    And I have clicked the link "Delete" of a project named "StrageProject2"
    Then I should see project "StrageProject2" disappears

  Scenario: Add emails of collaborator
    When I have clicked "Add new project"
    And I create a new project with name "StrageProject2" and http web link "http://www.abc.com"
    And I have clicked the link "Edit" of a project named "StrageProject2"
    And I have modified text_field of "Emails of Collaborators: (use ';' to separate email)" with new content "eric2@eric.com;eric3@eric.com"
    And I have clicked "Save Changes"
    And I click link "Sign Out"
    Given I am on the home page
    And I sign in email "eric2@eric.com" and password "Ff123456"
    When I am on the Projects List page
    Then I should see the listing projects including name "StrageProject2"

  Scenario: check illegal emails of collaborator
    When I have clicked "Add new project"
    And I create a new project with name "StrageProject2" and http web link "http://www.abc.com"
    And I have clicked the link "Edit" of a project named "StrageProject2"
    And I have modified text_field of "Emails of Collaborators: (use ';' to separate email)" with new content "sheenxh@google.com;eric3@eric.com"
    And I have clicked "Save Changes"
    Then I see "There are illegal or repeated emails of collaborators, or an email is not in the our system account. Please check it again." on the page