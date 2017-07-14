Feature: Edit a portfolio and delete a portfolio
    Background: 
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | eric@eric.com  | Ff123456  | first_name |last_name | street | city | IA    | 12345   | 1231231231 |
        | eric2@eric.com | Ff123456  | first_name |last_name | street | city | IA    | 12345   | 1231231231 |
        And the following groups exist:
        | user_email       | name     | description       |  picture   |
        | eric@eric.com    | Group 1  | eric@eric.com g1  | none       |
        | eric@eric.com    | Group 2  | eric@eric.com g2  | none       |
        | eric2@eric.com   | Group 3  | eric2@eric.com g3 | none       |
        | eric2@eric.com   | Group 4  | eric2@eric.com g4 | none       |
        And the following projects exist:
        | user_email       | name       | description       | Impact  | begin_date  | end_date  | group   |
        | eric@eric.com    | Project 1  | eric@eric.com p1  | x       | 9-1-1992    | 9-1-1992  | Group 1 |
        | eric@eric.com    | Project 2  | eric@eric.com p2  | x       | 9-1-1992    | 9-1-1992  | Group 1 |
        | eric@eric.com    | Project 3  | eric@eric.com p3  | x       | 9-1-1992    | 9-1-1992  | Group 2 |
        | eric@eric.com    | Project 4  | eric@eric.com p4  | x       | 9-1-1992    | 9-1-1992  | Group 2 |
        | eric2@eric.com   | Project 5  | eric2@eric.com p1 | x       | 9-1-1992    | 9-1-1992  | Group 3 |
        | eric2@eric.com   | Project 6  | eric2@eric.com p2 | x       | 9-1-1992    | 9-1-1992  | Group 3 |
        | eric2@eric.com   | Project 7  | eric2@eric.com p3 | x       | 9-1-1992    | 9-1-1992  | Group 4 |
        | eric2@eric.com   | Project 8  | eric2@eric.com p4 | x       | 9-1-1992    | 9-1-1992  | Group 4 |
        And the following portfolios exist:
        | user_email       | name         | description          | project_1   |  p1_visible  |  project_2   |  p2_visible  |  project_3  | p3_visible  |   project_4   |  p4_visible  |
        | eric@eric.com    | Portfolio 1  | eric@eric.com port1  | Project 1   | true         |  Project 2   |  false       |  Project 3  | true        |   Project 4   |  false       |
        | eric@eric.com    | Portfolio 2  | eric@eric.com port2  | Project 1   | false        |  Project 2   |  true        |  Project 3  | false       |   Project 4   |  true        | 
        And I sign in email "eric@eric.com" and password "Ff123456"
        And I am on the Portfolio List page
        
    Scenario: Ensure a user is able to access the edit page
        When I click "Edit" for portfolio "Portfolio 2"
        Then I see "Editing Portfolio" on the page
        
    Scenario: Ensure user is able to edit the portfolio from the edit page and have the result reflect on the Portfolio List page
        When I click "Edit" for portfolio "Portfolio 2"
        And I select the following portfolio properties:
        |  name         |   description       |
        | Portfolio 20  | eric@eric.com port1 |
        And I select projects: "Project 1, Project 3"
        And I click button "Save Changes"
        Then I see "My Portfolio List" on the page
        And I see only the following portfolios on the page: "Portfolio 20, Portfolio 2"
        
    Scenario: Ensure user is able to edit the portfolio from the edit page and have the result reflect on the Show Portfolio page
        When I click "Edit" for portfolio "Portfolio 2"
        And I select the following portfolio properties:
        |  name         |   description       |
        | Portfolio 20  | eric@eric.com port1 |
        And I select projects: "Project 1, Project 3"
        And I click button "Save Changes"
        Then I see "Portfolio 20" on the page
        
    Scenario: Ensure a user is able to delete an existing portfolio
        When I click "Delete" for portfolio "Portfolio 2"
        Then I see only the following portfolios on the page: "Portfolio 1"
        
    Scenario: Ensure that able to edit random styling
        When I click "Edit" for portfolio "Portfolio 2"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 2"
        Then I see "Randomized styling is set for this portfolio" on the page
        
    Scenario: Ensure that able to edit random styling
        When I click "Edit" for portfolio "Portfolio 2"
        And I select the template "hawks"  
        And I click button "Save Changes"
        When I click "Edit" for portfolio "Portfolio 2"
        Then I see "hawks" checked on the page
        
    Scenario: Ensure that able to edit random styling
        When I click "Edit" for portfolio "Portfolio 2"
        And I select the template "hawks"  
        And I click button "Save Changes"
        When I click "Edit" for portfolio "Portfolio 2"
        Then I see "hawks" checked on the page

    Scenario: Ensure that able to edit random styling
        When I click "Edit" for portfolio "Portfolio 2"
        And I select the template "blue"  
        And I click button "Save Changes"
        When I click "Edit" for portfolio "Portfolio 2"
        Then I see "blue" checked on the page 
        
    Scenario: Ensure that able to edit random styling
        When I click "Edit" for portfolio "Portfolio 2"
        And I select the template "red"  
        And I click button "Save Changes"
        When I click "Edit" for portfolio "Portfolio 2"
        Then I see "red" checked on the page
        
    Scenario: Ensure that able to edit random styling
        When I click "Edit" for portfolio "Portfolio 2"
        And I select the template "yellow"  
        And I click button "Save Changes"
        When I click "Edit" for portfolio "Portfolio 2"
        Then I see "yellow" checked on the page
        
    Scenario: Ensure that able to edit random styling
        When I click "Edit" for portfolio "Portfolio 2"
        And I select the template "colorful"  
        And I click button "Save Changes"
        When I click "Edit" for portfolio "Portfolio 2"
        Then I see "colorful" checked on the page    