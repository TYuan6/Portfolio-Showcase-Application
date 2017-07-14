Feature: Group Management


    Scenario: View Manage Project Groups button
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I see "Manage Project Groups" on the page

    Scenario: View existing groups then back to homepage
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I click button "Manage Project Groups"
        And I see "My Group List" on the page
        Then  I click link "Back to Home Page"
        And I am on the home page
    
    
    Scenario: Visite new group path
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I click button "Manage Project Groups"
        And I click link "Add new group"
        And I am on the page for creating a new group
  
    Scenario: Create a new group
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I click button "Manage Project Groups"
        And I click link "Add new group"
        And I create a new group "Group1"
        
        
    Scenario: Fail to create a new group
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I click button "Manage Project Groups"
        And I click link "Add new group"
        And I create a new group "Group1"
        And I click link "Add new group"
        And I create a new group "Group1"
        And I see "Name has already been taken" on the page
        
    
    
    Scenario: Show a group 
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I click button "Manage Project Groups"
        And I click link "Add new group"
        And I create a new group "Group1"
        And I click link "Show"
        And I see "Group1" on the page

    
    Scenario: Edit a group
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I click button "Manage Project Groups"
        And I click link "Add new group"
        And I create a new group "Group1"
        And I click link "Edit"
        And I edit a existing group name to "Group 1 editted"
        And I see "Group 1 editted" on the page

    Scenario: Fail to edit a group
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I click button "Manage Project Groups"
        And I click link "Add new group"
        And I create a new group "Group1"
        And I click link "Edit"
        And I edit a existing group name to ""
        And I see "Editing Group" on the page
        
    Scenario: Delete a group
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I click button "Manage Project Groups"
        And I create a new group "Group1"
        And I click link "Delete"
   
   
    
    


    
    
    