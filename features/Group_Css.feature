Feature: Group Css Management
  
    Background: 
        Given the users exist:
        | email           | password   | first_name |last_name | street | city | state | zipcode | phone      | 
        | asdf@asdf.com   | Asdfasdf1  | first_name |last_name | street | city | IA    | 12345   | 1231231231 |
        | asdf2@asdf.com  | Asdfasdf1  | first_name |last_name | street | city | IA    | 12345   | 1231231231 |
        And these following groups exist:
        | user_email        | name     | description        |
        | asdf@asdf.com     | Group 1  | asdf@asdf.com g1   |
        | asdf@asdf.com     | Group 2  | asdf@asdf.com g2   |
        | asdf2@asdf.com    | Group 3  | asdf2@asdf.com g3  |
        | asdf2@asdf.com    | Group 4  | asdf2@asdf.com g4  |
        And the following projects exist:
        | user_email       | name       | description       | Impact  | begin_date  | end_date  | group   |
        | asdf@asdf.com    | Project 1  | asdf@asdf.com p1  | x       | 9-1-1992    | 9-1-1992  | Group 1 |
        | asdf@asdf.com    | Project 2  | asdf@asdf.com p2  | x       | 9-1-1992    | 9-1-1992  | Group 1 |
        | asdf@asdf.com    | Project 3  | asdf@asdf.com p3  | x       | 9-1-1992    | 9-1-1992  | Group 2 |
        | asdf@asdf.com    | Project 4  | asdf@asdf.com p4  | x       | 9-1-1992    | 9-1-1992  | Group 2 |
        | asdf2@asdf.com   | Project 5  | asdf2@asdf.com p5 | x       | 9-1-1992    | 9-1-1992  | Group 3 |
        | asdf2@asdf.com   | Project 6  | asdf2@asdf.com p6 | x       | 9-1-1992    | 9-1-1992  | Group 3 |
        | asdf2@asdf.com   | Project 7  | asdf2@asdf.com p7 | x       | 9-1-1992    | 9-1-1992  | Group 4 |
        | asdf2@asdf.com   | Project 8  | asdf2@asdf.com p8 | x       | 9-1-1992    | 9-1-1992  | Group 4 |
        And I sign in email "asdf@asdf.com" and password "Asdfasdf1"
        And I am on the Create New Portfolio page
        When I select the following portfolio properties:
        |  name         |   description       |
        | Portfolio 1   | asdf@asdf.com port1 |
        And I select projects: "Project 1, Project 4"
        And I click button "Create Portfolio"
        And I am on the Create New Portfolio page
        When I select the following portfolio properties:
        |  name         |   description       |
        | Portfolio 2   | asdf@asdf.com port2 |
        And I select projects: "Project 1, Project 4"
        And I click button "Create Portfolio"
        And I am on the home page
        And I click button "Manage Portfolios"
  
    Scenario: View Groups in Portfolio Edit
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see "Group 1" on the page
        And I see "Group 2" on the page
        And I dont see "Group 3" on the page
        And I dont see "Group 4" on the page
        
    Scenario: View Groups in Portfolio Show
        When I click "Show" for portfolio "Portfolio 1"
        Then I see "Group 1" on the page
        And I see "Group 2" on the page
        And I dont see "Group 3" on the page
        And I dont see "Group 4" on the page
        
    Scenario: Back button in Portfolio Edit Group CSS view
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I click button "Back To Portfolio"
        Then I see "My Portfolio List" on the page
        
    Scenario: Back button in Portfolio Show Group CSS view
        When I click "Show" for portfolio "Portfolio 1"
        And I click button "Back To Portfolio"
        Then I see "My Portfolio List" on the page
        
    Scenario: Edit Group Css to Visible
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I check "Group 2" visible for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "Group 2" on the page
        
    Scenario: Edit Group Css to not Visible
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I uncheck "Group 1" visible for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I dont see "Group 1" on the page
    
    Scenario: Show Group Background Css default to off
        When I view portfolio "Portfolio 1"
        Then I dont see "background-image: url" on the page
        
    Scenario: Edit Group Background Css to true
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I check "Group 1" background for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "background-image: url" on the page
        
    Scenario: Edit Group Default Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Default Style" to "Red - Square - Small" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "smallRed" on the page
        
    Scenario: Show Group Css default position is static
        When I view portfolio "Portfolio 1"
        Then I see "static" on the page
        
    Scenario: Edit Group Position
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Position" to "absolute" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "absolute" on the page
        
    Scenario: Show Group Font Type default to Times New Roman
        When I view portfolio "Portfolio 1"
        Then I see "Times New Roman" on the page
        
    Scenario: Edit Group Font Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Font" to "Arial" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "Arial" on the page
        
    Scenario: Show Group Shadow default to ""
        When I view portfolio "Portfolio 1"
        Then I dont see "shadow" on the page
        
    Scenario: Edit Group Shadow Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Box Shadow" to "shadowRed" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "shadowRed" on the page
        
    Scenario: Show Group Hover default to ""
        When I view portfolio "Portfolio 1"
        Then I dont see "hover" on the page
        
    Scenario: Edit Group Hover Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Hover" to "hoverRed" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "hoverRed" on the page
        
    Scenario: Show Group Width default to 40%
        When I view portfolio "Portfolio 1"
        Then I see "width: 40%" on the page
        
    Scenario: Edit Group Width Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Width" to "53" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "width: 53%" on the page
        
    Scenario: Show Group Height default to 40vh
        When I view portfolio "Portfolio 1"
        Then I see "height: 40vh" on the page
        
    Scenario: Edit Group Height Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Height" to "13" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "height: 13vh" on the page
        
    Scenario: Show Group Top default to 0%
        When I view portfolio "Portfolio 1"
        Then I see "top: 0%" on the page
        
    Scenario: Edit Group Top Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Top" to "27" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "top: 27%" on the page
        
    Scenario: Show Group Left default to 0%
        When I view portfolio "Portfolio 1"
        Then I see "left: 0%" on the page
        
    Scenario: Edit Group Left Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Left" to "67" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "left: 67%" on the page
        
    Scenario: Show Group Font Size default to 100%
        When I view portfolio "Portfolio 1"
        Then I see "font-size: 100" on the page
        
    Scenario: Edit Group Font Size
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Font Size" to "55" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "font-size: 55" on the page
        
    Scenario: Show Group Font Color default to #000000
        When I view portfolio "Portfolio 1"
        Then I see "color: #000000" on the page
        
    Scenario: Edit Group Font Color Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Color" to "#111111" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "color: #111111" on the page
        
    Scenario: Show Group Background Color default to $ffffff
        When I view portfolio "Portfolio 1"
        Then I see "background-color: #ffffff" on the page
        
    Scenario: Edit Group Background Color Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Background Color" to "#222222" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "background-color: #222222" on the page
        
    Scenario: Show Group Opacity default to 1
        When I view portfolio "Portfolio 1"
        Then I see "opacity: 1.0" on the page
        
    Scenario: Edit Group Opacity Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Opacity" to "0.5" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "opacity: 0.5" on the page
        
    Scenario: Show Group Border Radius default to 2%
        When I view portfolio "Portfolio 1"
        Then I see "border-radius: 2%" on the page
        
    Scenario: Edit Group Border Radius Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Radius" to "10" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "border-radius: 10%" on the page
        
    Scenario: Show Group Border Color default to #000000
        When I view portfolio "Portfolio 1"
        Then I see "border-color: #000000" on the page
        
    Scenario: Edit Group Border Color Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Color" to "#333333" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "border-color: #333333" on the page
        
    Scenario: Show Group Border Size default to 4px
        When I view portfolio "Portfolio 1"
        Then I see "border-width: 4px" on the page
        
    Scenario: Edit Group Border Size Style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Size" to "10" for "Portfolio 1"
        And I click button "Update Styling"
        And I view portfolio "Portfolio 1"
        Then I see "border-width: 10px" on the page

    Scenario: Error message for Group Width 
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Width" to "-1" for "Portfolio 1"
        And I click button "Update Styling"
        Then I see "Width must be greater than or equal to 0.0" on the page

    Scenario: Error message for Group Height 
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Height" to "-2" for "Portfolio 1"
        And I click button "Update Styling"
        Then I see "Height must be greater than or equal to 0.0" on the page
        
    Scenario: Error message for Group Top 
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Top" to "-3" for "Portfolio 1"
        And I click button "Update Styling"
        Then I see "Top must be greater than or equal to 0.0" on the page
        
    Scenario: Error message for Group Left 
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Left" to "-4" for "Portfolio 1"
        And I click button "Update Styling"
        Then I see "Left must be greater than or equal to 0.0" on the page
        
    Scenario: Error message for Group Font Size
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Font Size" to "-5" for "Portfolio 1"
        And I click button "Update Styling"
        Then I see "Fontsize must be greater than or equal to 0.0" on the page
        
    Scenario: Error message for Group Opacity
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Opacity" to "-1" for "Portfolio 1"
        And I click button "Update Styling"
        Then I see "Opacity must be greater than or equal to 0.0" on the page
        
    Scenario: Error message for Group Border Radius
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Radius" to "-1" for "Portfolio 1"
        And I click button "Update Styling"
        Then I see "Borderradius must be greater than or equal to 0.0" on the page
        
    Scenario: Error message for Group Border Size
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Size" to "-1" for "Portfolio 1"
        And I click button "Update Styling"
        Then I see "Bordersize must be greater than or equal to 0.0" on the page
        
    Scenario: Random for editing group css default
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see defaultStyle is in the acceptable values for group 1
        
    Scenario: Random for editing group css position
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see position is in the acceptable values for group 1

    Scenario: Random for editing group css width
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see width is in the acceptable values for group 1
        
    Scenario: Random for editing group css height
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see height is in the acceptable values for group 1
        
    Scenario: Random for editing group css top
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see top is in the acceptable values for group 1
        
    Scenario: Random for editing group css left
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see left is in the acceptable values for group 1
        
    Scenario: Random for editing group css font type
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see font type is in the acceptable values for group 1
        
    Scenario: Random for editing group css opacity
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see opacity is in the acceptable values for group 1
        
    Scenario: Random for editing group css border radius
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see border radius is in the acceptable values for group 1
        
    Scenario: Random for editing group css border size
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see border size is in the acceptable values for group 1
        
    Scenario: Random for editing group css box shadow 
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see box shadow is in the acceptable values for group 1
        
    Scenario: Random for editing group css hover
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random  
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I see hover is in the acceptable values for group 1        
        
    Scenario: Saved random styles show in show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random   
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I save and check updates carry over to show views for groups
        
    Scenario: Saved random styles show in shared views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I set the portfolio to random   
        And I click button "Save Changes"
        When I click "Edit Styling" for portfolio "Portfolio 1"
        Then I save and check updates carry over to show views for "Portfolio 1"
        
    Scenario: Saved howks styles applied in show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "hawks"   
        And I click button "Save Changes"
        And I am viewing show groups for Group 1
        Then I see "Hawks" on the page
        
    Scenario: Saved howks styles applied in shared show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "hawks"   
        And I click button "Save Changes"
        And I am viewing shared show groups for Group 1
        Then I see "Hawks" on the page

    Scenario: Saved colorful styles applied in show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "colorful"   
        And I click button "Save Changes"
        And I am viewing show groups for Group 1
        Then I see "Colorful" on the page
        
    Scenario: Saved colorful styles applied in shared show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "colorful"   
        And I click button "Save Changes"
        And I am viewing shared show groups for Group 1
        Then I see "Colorful" on the page

    Scenario: Saved red styles applied in show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "red"   
        And I click button "Save Changes"
        And I am viewing show groups for Group 1
        Then I see "Red" on the page
        
    Scenario: Saved red styles applied in shared show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "red"   
        And I click button "Save Changes"
        And I am viewing shared show groups for Group 1
        Then I see "Red" on the page

    Scenario: Saved blue styles applied in show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "blue"   
        And I click button "Save Changes"
        And I am viewing show groups for Group 1
        Then I see "Blue" on the page
        
    Scenario: Saved blue styles applied in shared show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "blue"   
        And I click button "Save Changes"
        And I am viewing shared show groups for Group 1
        Then I see "Blue" on the page
        
    Scenario: Saved yellow styles applied in show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "yellow"   
        And I click button "Save Changes"
        And I am viewing show groups for Group 1
        Then I see "Yellow" on the page
        
    Scenario: Saved yellow styles applied in shared show views for groups
        When I click "Edit" for portfolio "Portfolio 1"
        And I select the template "yellow"   
        And I click button "Save Changes"
        And I am viewing shared show groups for Group 1
        Then I see "Yellow" on the page

    Scenario: Group css copy works for show view shadow
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Box Shadow" to "shadowRed" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "shadowRed" on the page
        
    Scenario: Group css copy works for shared show view shadow
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Box Shadow" to "shadowRed" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "shadowRed" on the page
        
    Scenario: Group css copy works for show view default
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Default Style" to "Red - Square - Small" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "smallRed" on the page
        
    Scenario: Group css copy works for shared show view default
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Default Style" to "Red - Square - Small" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "smallRed" on the page       
        
    Scenario: Group css copy works for show view position
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Position" to "absolute" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "absolute" on the page
        
    Scenario: Group css copy works for shared show view position
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Position" to "absolute" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "absolute" on the page 

    Scenario: Group css copy works for show view font style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Font" to "Arial" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "Arial" on the page
        
    Scenario: Group css copy works for shared show view font style
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Font" to "Arial" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "Arial" on the page 
        
    Scenario: Group css copy works for show view hover
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Hover" to "hoverRed" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "hoverRed" on the page
        
    Scenario: Group css copy works for shared show view hover
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I set "Group 1" "Hover" to "hoverRed" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "hoverRed" on the page 
     
     Scenario: Group css copy works for show view width
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Width" to "53" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "width: 53%" on the page
        
    Scenario: Group css copy works for shared show view width
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Width" to "53" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "width: 53%" on the page 
        
    Scenario: Group css copy works for show view height
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Height" to "13" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "height: 13vh" on the page
        
    Scenario: Group css copy works for shared show view height
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Height" to "13" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "height: 13vh" on the page 
    
    Scenario: Group css copy works for show view top
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Top" to "27" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "top: 27%" on the page
        
    Scenario: Group css copy works for shared show view top
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Top" to "27" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "top: 27%" on the page 
        
    Scenario: Group css copy works for show view left
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Left" to "67" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "left: 67%" on the page
        
    Scenario: Group css copy works for shared show view left
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Left" to "67" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "left: 67%" on the page 
        
    Scenario: Group css copy works for show view font size
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Font Size" to "55" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "font-size: 55" on the page
        
    Scenario: Group css copy works for shared show view font size
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Font Size" to "55" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "font-size: 55" on the page 
        
    Scenario: Group css copy works for show view font color
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Color" to "#111111" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "color: #111111" on the page
        
    Scenario: Group css copy works for shared show view font color
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Color" to "#111111" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "color: #111111" on the page 
        
    Scenario: Group css copy works for show view background color
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Background Color" to "#222222" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "background-color: #222222" on the page
        
    Scenario: Group css copy works for shared show view background color
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Background Color" to "#222222" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "background-color: #222222" on the page 
        
    Scenario: Group css copy works for show view opacity
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Opacity" to "0.5" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "opacity: 0.5" on the page
        
    Scenario: Group css copy works for shared show view opacity
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Opacity" to "0.5" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "opacity: 0.5" on the page 
        
    Scenario: Group css copy works for show view radius
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Radius" to "10" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "border-radius: 10%" on the page
        
    Scenario: Group css copy works for shared show view radius
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Radius" to "10" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "border-radius: 10%" on the page 
        
    Scenario: Group css copy works for show view border color
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Color" to "#333333" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "border-color: #333333" on the page
        
    Scenario: Group css copy works for shared show view border color
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Color" to "#333333" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "border-color: #333333" on the page 
        
    Scenario: Group css copy works for show view border size
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Size" to "10" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I view portfolio "Portfolio 1"
        Then I see "border-width: 10px" on the page
        
    Scenario: Group css copy works for shared show view border size
        When I click "Edit Styling" for portfolio "Portfolio 1"
        And I input "Group 1" "Border Size" to "10" for "Portfolio 1"
        And I click button "Update Styling"
        And I click link "Manage Portfolios"
        And I click "Edit" for portfolio "Portfolio 2"
        And I select "Portfolio 1" to copy style from
        And I click button "Save Changes"
        And I am viewing shared show groups for "Portfolio 2"
        Then I see "border-width: 10px" on the page 
