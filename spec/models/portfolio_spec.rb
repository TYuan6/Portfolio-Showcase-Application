require 'rails_helper'


RSpec.describe Portfolio do
    
    before(:each) do
      
        group1 = Group.create(:name => "Group 1", :description => "First group created for eric")
        group2 = Group.create(:name => "Group 2", :description => "Second group created for eric")
        portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric")
        portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric")
        project1 = Proj.create(:name => "Project 1", :description => "First project created for eric")
        project2 = Proj.create(:name => "Project 2", :description => "Second project created for eric")
        project1.group = group1
        project1.save
        project2.group = group2
        project2.save
        portfolio1.projs << project1
        portfolio1.projs << project2
        portfolio2.projs << project1
        portfolio2.projs << project2
        portfolio1.groups << group1
        portfolio1.groups << group2
        portfolio2.groups << group1
        portfolio2.groups << group2
        #now assign the visibility.  Portfolio 1 is going to have projects in group 1's visibility off and no projects part of group 2
        tempCss = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
        tempCss.visible = true
        tempCss.defaultStyle = "mediumRed"
        tempCss.position = "absolute"
        tempCss.width = 20
        tempCss.height = 30
        tempCss.top = "20"
        tempCss.left = "30"
        tempCss.font = "Times New Roman"
        tempCss.fontSize = 50
        tempCss.color = "#FFFFFF"
        tempCss.backgroundColor = "#000000"
        tempCss.opacity = 0.0
        tempCss.borderRadius = 1
        tempCss.borderColor = "#FFFFFF"
        tempCss.borderSize = 2
        tempCss.boxShadow = "shadowRed"
        tempCss.hover = "hoverRed"
        tempCss.background = true
        tempCss.save
        tempCss = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group2.id).take
        tempCss.visible = true
        tempCss.defaultStyle = "mediumRed"
        tempCss.position = "absolute"
        tempCss.width = 20
        tempCss.height = 30
        tempCss.top = "20"
        tempCss.left = "30"
        tempCss.font = "Times New Roman"
        tempCss.fontSize = 50
        tempCss.color = "#FFFFFF"
        tempCss.backgroundColor = "#000000"
        tempCss.opacity = 0.0
        tempCss.borderRadius = 1
        tempCss.borderColor = "#FFFFFF"
        tempCss.borderSize = 2
        tempCss.boxShadow = "shadowRed"
        tempCss.hover = "hoverRed"
        tempCss.background = true
        tempCss.save
        #Now the ProjCss
        tempCss = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project1.id).take
        tempCss.visible = true
        tempCss.defaultStyle = "mediumRed"
        tempCss.position = "absolute"
        tempCss.width = 20
        tempCss.height = 30
        tempCss.top = "20"
        tempCss.left = "30"
        tempCss.font = "Times New Roman"
        tempCss.fontSize = 50
        tempCss.color = "#FFFFFF"
        tempCss.backgroundColor = "#000000"
        tempCss.opacity = 0.0
        tempCss.borderRadius = 1
        tempCss.borderColor = "#FFFFFF"
        tempCss.borderSize = 2
        tempCss.boxShadow = "shadowRed"
        tempCss.hover = "hoverRed"
        tempCss.background = true
        tempCss.save
        tempCss = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project2.id).take
        tempCss.visible = true
        tempCss.defaultStyle = "mediumRed"
        tempCss.position = "absolute"
        tempCss.width = 20
        tempCss.height = 30
        tempCss.top = "20"
        tempCss.left = "30"
        tempCss.font = "Times New Roman"
        tempCss.fontSize = 50
        tempCss.color = "#FFFFFF"
        tempCss.backgroundColor = "#000000"
        tempCss.opacity = 0.0
        tempCss.borderRadius = 1
        tempCss.borderColor = "#FFFFFF"
        tempCss.borderSize = 2
        tempCss.boxShadow = "shadowRed"
        tempCss.hover = "hoverRed"
        tempCss.background = true
        tempCss.save

      
    end
    
    
    describe "copyCssInfo" do
        it "copies all portfolio styling from one portfolio to another except the visibility" do
            portfolio1 = Portfolio.find_by_name("Portfolio 1")
            portfolio2 = Portfolio.find_by_name("Portfolio 2")
            proj1 = Proj.find_by_name("Project 1")
            proj2 = Proj.find_by_name("Project 2")
            group1 = Group.find_by_name("Group 1")
            group2 = Group.find_by_name("Group 2")
            Portfolio.copyCssInfo(portfolio1.id, portfolio2.id)
            #First check portfolio2, project css #1
            tempCss = ProjCss.where(:portfolio_id => portfolio2, :proj_id => proj1.id).take
            expect(tempCss.visible).to eq(false)
            expect(tempCss.defaultStyle).to eq("mediumRed")
            expect(tempCss.position).to eq("absolute")
            expect(tempCss.width).to eq("20")
            expect(tempCss.height).to eq("30")
            expect(tempCss.top).to eq(20)
            expect(tempCss.left).to eq(30)
            expect(tempCss.font).to eq("Times New Roman")
            expect(tempCss.fontSize).to eq(50)
            expect(tempCss.color).to eq("#FFFFFF")
            expect(tempCss.backgroundColor).to eq("#000000")
            expect(tempCss.opacity).to eq(0.0)
            expect(tempCss.borderRadius).to eq(1)
            expect(tempCss.borderColor).to eq("#FFFFFF")
            expect(tempCss.borderSize).to eq(2)
            expect(tempCss.boxShadow).to eq("shadowRed")
            expect(tempCss.hover).to eq("hoverRed")
            expect(tempCss.background).to eq(true)
            tempCss = ProjCss.where(:portfolio_id => portfolio2, :proj_id => proj2.id).take
            expect(tempCss.visible).to eq(false)
            expect(tempCss.defaultStyle).to eq("mediumRed")
            expect(tempCss.position).to eq("absolute")
            expect(tempCss.width).to eq("20")
            expect(tempCss.height).to eq("30")
            expect(tempCss.top).to eq(20)
            expect(tempCss.left).to eq(30)
            expect(tempCss.font).to eq("Times New Roman")
            expect(tempCss.fontSize).to eq(50)
            expect(tempCss.color).to eq("#FFFFFF")
            expect(tempCss.backgroundColor).to eq("#000000")
            expect(tempCss.opacity).to eq(0.0)
            expect(tempCss.borderRadius).to eq(1)
            expect(tempCss.borderColor).to eq("#FFFFFF")
            expect(tempCss.borderSize).to eq(2)
            expect(tempCss.boxShadow).to eq("shadowRed")
            expect(tempCss.hover).to eq("hoverRed")
            expect(tempCss.background).to eq(true)
            tempCss = GroupCss.where(:portfolio_id => portfolio2, :group_id => group1.id).take
            expect(tempCss.visible).to eq(false)
            expect(tempCss.defaultStyle).to eq("mediumRed")
            expect(tempCss.position).to eq("absolute")
            expect(tempCss.width).to eq("20")
            expect(tempCss.height).to eq("30")
            expect(tempCss.top).to eq(20)
            expect(tempCss.left).to eq(30)
            expect(tempCss.font).to eq("Times New Roman")
            expect(tempCss.fontSize).to eq(50)
            expect(tempCss.color).to eq("#FFFFFF")
            expect(tempCss.backgroundColor).to eq("#000000")
            expect(tempCss.opacity).to eq(0.0)
            expect(tempCss.borderRadius).to eq(1)
            expect(tempCss.borderColor).to eq("#FFFFFF")
            expect(tempCss.borderSize).to eq(2)
            expect(tempCss.boxShadow).to eq("shadowRed")
            expect(tempCss.hover).to eq("hoverRed")
            expect(tempCss.background).to eq(true)
            tempCss = GroupCss.where(:portfolio_id => portfolio2, :group_id => group2.id).take
            expect(tempCss.visible).to eq(false)
            expect(tempCss.defaultStyle).to eq("mediumRed")
            expect(tempCss.position).to eq("absolute")
            expect(tempCss.width).to eq("20")
            expect(tempCss.height).to eq("30")
            expect(tempCss.top).to eq(20)
            expect(tempCss.left).to eq(30)
            expect(tempCss.font).to eq("Times New Roman")
            expect(tempCss.fontSize).to eq(50)
            expect(tempCss.color).to eq("#FFFFFF")
            expect(tempCss.backgroundColor).to eq("#000000")
            expect(tempCss.opacity).to eq(0.0)
            expect(tempCss.borderRadius).to eq(1)
            expect(tempCss.borderColor).to eq("#FFFFFF")
            expect(tempCss.borderSize).to eq(2)
            expect(tempCss.boxShadow).to eq("shadowRed")
            expect(tempCss.hover).to eq("hoverRed")
            expect(tempCss.background).to eq(true)
            
        end
    end
    
    describe "all_templates" do
       it 'returns ["Hawks", "Colorful", "Red", "Blue", "Yellow"]' do
           expect(Portfolio.all_templates).to eq(["Hawks", "Colorful", "Red", "Blue", "Yellow"])
       end
    end
    
    describe "all_colors" do
       it 'returns [["Red"], ["Blue"], ["Yellow"]]' do
           expect(Portfolio.all_colors).to eq([["Red"], ["Blue"], ["Yellow"]])
       end
    end
        
    
end