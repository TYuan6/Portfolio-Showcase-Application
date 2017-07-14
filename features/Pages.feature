Feature: User Navigation Of Standard Pages
    Scenario: Select about link
        Given I am on the home page
        When I click link "About"
        Then I see "About Page" on the page
  
      Scenario: Select styles link
        Given I am on the home page
        When I click link "Example Styles"
        Then I see "Styles Page" on the page
        
    Scenario: Select Home Logged in
        Given I am on the home page
        And the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I see "Manage Project Groups" on the page
        
    Scenario: Select Home Logged out
        When I go to "/"
        Then I see "Forgot your password?" on the page
        
    Scenario: Ensure the Manage Portfolios page is accessible
        Given I am on the home page
        And the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        And I click button "Manage Portfolios"
        Then I see "My Portfolio List" on the page
        
    Scenario: Ensure the Manage Projects page is accessible
        Given I am on the home page
        And the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        And I click button "Manage Projects"
        Then I see "My Project List" on the page
        
    Scenario: Ensure the Manage Groups page is accessible
        Given I am on the home page
        And the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        And I click button "Manage Project Groups"
        Then I see "My Group List" on the page
        
    Scenario: Ensure the Home button works
        And the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        And I click button "Manage Project Groups"
        And I click link "Home"
        Then I see "Buckets for organizing all of your projects" on the page
    
    
    
      Scenario: Select public Portfolio link
        Given I am on the home page
        When I click link "Public Portfolio"
        Then I see "The Latest Portfolios" on the page