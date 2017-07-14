Feature: User Session Management
  
    Scenario: Not logged in, sign in avaliable
        Given I am on the home page
        Then I see "Sign In" on the page
        
    Scenario: Not logged in, sign up avaliable
        Given I am on the home page
        Then I see "Sign Up" on the page
        
    Scenario: Logged in, edit profile avaliable
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I see "Edit Profile" on the page
        
    Scenario: Logged in, sign out avaliable
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I see "Sign Out" on the page
        
    Scenario: Signing in to account success notification
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        Then I see "Signed in successfully" on the page
    
    Scenario: Signing in to account fail notification
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf12"
        Then I see "Invalid Email or password" on the page
      
    Scenario: Signing out of account notification
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        And I click link "Sign Out"
        Then I see "Signed out successfully" on the page
      
    Scenario: Account creation failure
        Given I am on the home page
        When I click link "Sign Up"
        And I click button "Sign up"
        Then I see "Email can&#39;t be blank" on the page
        And I see "Password can&#39;t be blank" on the page
        And I see "Password must contain big, small letters and digits" on the page
        And I see "First name can&#39;t be blank" on the page
        And I see "Last name can&#39;t be blank" on the page
        And I see "Street can&#39;t be blank" on the page
        And I see "City can&#39;t be blank" on the page
        And I see "State can&#39;t be blank" on the page
        And I see "Zipcode must be 5 digits" on the page
        And I see "Phone must be 10 digits" on the page

    Scenario: Account creation pass
        When I create a new valid user
        Then I see "You have signed up successfully" on the page

    Scenario: Account creation failure duplicate email
        Given I am on the home page
        And the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I create user with email "asdf@asdf.com"
        Then I see "Email has already been taken" on the page
        
    Scenario: Account creation failure mismatch passwords
        When I create user with mismatched passwords
        Then I see "Password confirmation doesn&#39;t match Password" on the page
        
    Scenario: Logged in, edit profile works
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        And I edit my name to "test" for default user
        Then I see "test" on the page
        
    Scenario: Logged in, edit profile validations works
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com  | Asdfasdf1 | first_name |last_name | street | city | IA    | 12345   | 1231231231 | 
        When I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        And I edit my name to "test" for default user with no password
        Then I see "Current password can&#39;t be blank" on the page


    