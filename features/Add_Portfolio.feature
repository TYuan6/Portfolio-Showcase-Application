Feature: Add new portfolios
  
    Background: 
        Given the users exist:
        | email          | password  | first_name |last_name | street | city | state | zipcode | phone      | 
        | eric@eric.com  | Ff123456  | first_name |last_name | street | city | IA    | 12345   | 1231231231 |
        | eric2@eric.com | Ff123456  | first_name |last_name | street | city | IA    | 12345   | 1231231231 |
        And the following groups exist:
        | user_email       | name     | description       |
        | eric@eric.com    | Group 1  | eric@eric.com g1  |
        | eric@eric.com    | Group 2  | eric@eric.com g2  |
        | eric2@eric.com   | Group 3  | eric2@eric.com g3 |
        | eric2@eric.com   | Group 4  | eric2@eric.com g4 |
        And the following projects exist:
        | user_email       | name       | description       | Impact  | begin_date  | end_date  | group   |
        | eric@eric.com    | Project 1  | eric@eric.com p1  | x       | 9-1-1992    | 9-1-1992  | Group 1 |
        | eric@eric.com    | Project 2  | eric@eric.com p2  | x       | 9-1-1992    | 9-1-1992  | Group 1 |
        | eric@eric.com    | Project 3  | eric@eric.com p3  | x       | 9-1-1992    | 9-1-1992  | Group 2 |
        | eric@eric.com    | Project 4  | eric@eric.com p4  | x       | 9-1-1992    | 9-1-1992  | Group 2 |
        | eric2@eric.com   | Project 5  | eric2@eric.com p5 | x       | 9-1-1992    | 9-1-1992  | Group 3 |
        | eric2@eric.com   | Project 6  | eric2@eric.com p6 | x       | 9-1-1992    | 9-1-1992  | Group 3 |
        | eric2@eric.com   | Project 7  | eric2@eric.com p7 | x       | 9-1-1992    | 9-1-1992  | Group 4 |
        | eric2@eric.com   | Project 8  | eric2@eric.com p8 | x       | 9-1-1992    | 9-1-1992  | Group 4 |
    
    Scenario: Ensure I can get to the add new portfolio page
        Given I sign in email "eric@eric.com" and password "Ff123456"
        And I am on the Portfolio List page
        When I click link "Add new portfolio"
        Then I see "New Portfolio" on the page
      
    Scenario: Ensure that all the projects entered are displayed for selection on the new portfolio page
        Given I sign in email "eric@eric.com" and password "Ff123456"
        And I am on the Create New Portfolio page
        Then I see only the following projects displayed:
        | name       | description       | group   |
        | Project 1  | eric@eric.com p1  | Group 1 |
        | Project 2  | eric@eric.com p2  | Group 1 |
        | Project 3  | eric@eric.com p3  | Group 2 |
        | Project 4  | eric@eric.com p4  | Group 2 |
    
    Scenario: Ensure that able to create a portfolio and see it on the All Portfolios page
        Given I sign in email "eric@eric.com" and password "Ff123456"
        And I am on the Create New Portfolio page
        When I select the following portfolio properties:
        |  name         |   description       |
        | Portfolio 1   | eric@eric.com port1 |
        And I select projects: "Project 1, Project 4"
        And I click button "Create Portfolio"
        Then I see "My Portfolio List" on the page
        And I see only the following portfolios on the page: "Portfolio 1"
        
    Scenario: Ensure that able to create a portfolio and turn on random styling
        Given I sign in email "eric@eric.com" and password "Ff123456"
        And I am on the Create New Portfolio page
        When I select the following portfolio properties:
        |  name         |   description       |
        | Portfolio 1   | eric@eric.com port1 |
        And I set the portfolio to random
        And I select projects: "Project 1, Project 4"
        And I click button "Create Portfolio"
        And I click link "Edit Styling"
        Then I see "Randomized styling is set for this portfolio" on the page
        
    Scenario: Ensure that able to create a portfolio without random styling
        Given I sign in email "eric@eric.com" and password "Ff123456"
        And I am on the Create New Portfolio page
        When I select the following portfolio properties:
        |  name         |   description       |
        | Portfolio 1   | eric@eric.com port1 |
        And I select projects: "Project 1, Project 4"
        And I click button "Create Portfolio"
        And I click link "Edit Styling"
        Then I dont see "Randomized styling is set for this portfolio" on the page
        
    Scenario: Ensure random styling warning links to edit page
        Given I sign in email "eric@eric.com" and password "Ff123456"
        And I am on the Create New Portfolio page
        When I select the following portfolio properties:
        |  name         |   description       |
        | Portfolio 1   | eric@eric.com port1 |
        And I set the portfolio to random
        And I select projects: "Project 1, Project 4"
        And I click button "Create Portfolio"
        And I click link "Edit Styling"
        And I click link "Edit Portfolio Settings"
        Then I see "Portfolio 1" on the page