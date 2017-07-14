require 'rails_helper'





RSpec.describe GroupCss do
    
    before(:each) do
      
        group1 = Group.create(:name => "Group 1", :description => "First group created for eric")
        group2 = Group.create(:name => "Group 2", :description => "Second group created for eric")
        portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric")
        portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric")
        project1 = Proj.create(:name => "Project 1", :description => "First project created for eric")
        project2 = Proj.create(:name => "Project 2", :description => "Second project created for eric")
        project3 = Proj.create(:name => "Project 3", :description => "Third project created for eric")
        project4 = Proj.create(:name => "Project 4", :description => "Fourth project created for eric")
        project1.group = group1
        project1.save
        project2.group = group2
        project2.save
        project3.group = group1
        project3.save
        project4.group = group2
        project4.save
        portfolio1.projs << project1
        portfolio1.projs << project2
        portfolio2.projs << project3
        portfolio2.projs << project4
        portfolio1.groups << group1
        portfolio1.groups << group2
        portfolio2.groups << group1
        portfolio2.groups << group2
        #now assign the visibility.  Portfolio 1 is going to have projects in group 1's visibility off and no projects part of group 2
        tempCss = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group2.id).take
        tempCss.visible = false
        tempCss.save
        # now assign the visiblility.  Portfolio 2 is going to have half the projects' visibility on and no projects part of group 2
        tempCss = GroupCss.where(:portfolio_id => portfolio2.id, :group_id => group1.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(:portfolio_id => portfolio2.id, :group_id => group2.id).take
        tempCss.visible = false
        tempCss.save
      
    end
    
    
    describe "Initial values" do
        it "sets the initial values correctly" do
            temp = GroupCss.new()
            temp.save
            expect(temp.visible).to eq(false)
            expect(temp.defaultStyle).to eq("")
            expect(temp.position).to eq("static")
            expect(temp.width).to eq("40")
            expect(temp.height).to eq("40")
            expect(temp.top).to eq(0)
            expect(temp.left).to eq(0)
            expect(temp.font).to eq("Times New Roman")
            expect(temp.fontSize).to eq(100)
            expect(temp.color).to eq("#000000")
            expect(temp.backgroundColor).to eq("#ffffff")
            expect(temp.opacity).to eq(1.0)
            expect(temp.borderRadius).to eq(2)
            expect(temp.borderColor).to eq("#000000")
            expect(temp.borderSize).to eq(4)
            expect(temp.boxShadow).to eq("")
            expect(temp.hover).to eq("")
            expect(temp.background).to eq(false)
        end
    end
    
    
    describe "DefaultStyle Validation" do
        it "accepts all of the positions in all_defaults" do
            temp = GroupCss.new()
            temp.save
            GroupCss.all_defaults_check.each do |default|
                temp.defaultStyle = default
                temp.validate
                expect(temp.valid?).to eq (true)
            end
        end
        it "Does not accept a position that is not in all_defaults" do
            temp = GroupCss.new()
            temp.defaultStyle = "hahahaha"
            temp.validate
            expect(temp.valid?).to eq(false)
        end
    end
    
    describe "Position Validation" do
        it "accepts all of the positions in all_positions" do
            temp = GroupCss.new()
            temp.save
            GroupCss.all_positions_check.each do |position|
                temp.position = position
                temp.save
                expect(temp.valid?).to eq (true)
            end
        end
        it "Does not accept a position that is not in all_positions" do
            temp = GroupCss.new()
            temp.position = "hahahaha"
            expect(temp.valid?).to eq(false)
        end
    end
    
    describe "Width Validation" do
        it "only accepts value between 0 and 100" do
            temp = GroupCss.new()
            temp.width = "0"
            expect(temp.valid?).to eq(true)
            temp.width = "100"
            expect(temp.valid?).to eq(true)
            temp.width = "-1"
            expect(temp.valid?).to eq(false)
            temp.width = "101"
            expect(temp.valid?).to eq(false)
            temp.width = ""
            expect(temp.valid?).to eq(true)
        end
    end
    
    describe "Height validation" do
        it "only accepts value between 0 and 100" do
            temp = GroupCss.new()
            temp.height = "0"
            expect(temp.valid?).to eq(true)
            temp.height = "100"
            expect(temp.valid?).to eq(true)
            temp.height = "-1"
            expect(temp.valid?).to eq(false)
            temp.height = "101"
            expect(temp.valid?).to eq(false)
            temp.height = ""
            expect(temp.valid?).to eq(true)
        end
    end
    
    describe "Top validation" do
        it "only accepts value greater than or equal to 0 and blank" do
            temp = GroupCss.new()
            temp.top = "0"
            expect(temp.valid?).to eq(true)
            temp.top = "100"
            expect(temp.valid?).to eq(true)
            temp.top = "-1"
            expect(temp.valid?).to eq(false)
            temp.top = "200"
            expect(temp.valid?).to eq(true)
            temp.top = nil
            expect(temp.valid?).to eq(true)
        end
    end
    
    describe "Left validation" do
        it "only accepts value greater than or equal to 0" do
            temp = GroupCss.new()
            temp.left = "0"
            expect(temp.valid?).to eq(true)
            temp.left = "100"
            expect(temp.valid?).to eq(true)
            temp.left = "-1"
            expect(temp.valid?).to eq(false)
            temp.left = "200"
            expect(temp.valid?).to eq(true)
            temp.left = nil
            expect(temp.valid?).to eq(true)
        end
    end
    
    describe "Font Validation" do
        it "accepts all of the fonts in all_fonts" do
            temp = GroupCss.new()
            GroupCss.all_fonts_check.each do |font|
                temp.font = font
                expect(temp.valid?).to eq (true)
            end
        end
        it "Does not accept a position that is not in all_fonts" do
            temp = GroupCss.new()
            temp.font = "hahahaha"
            expect(temp.valid?).to eq(false)
        end
    end
    
    
    describe "Font Size validation" do
        it "only accepts value greater than or equal to 0" do
            temp = GroupCss.new()
            temp.fontSize = "0"
            expect(temp.valid?).to eq(true)
            temp.fontSize = "100"
            expect(temp.valid?).to eq(true)
            temp.fontSize = "-1"
            expect(temp.valid?).to eq(false)
            temp.fontSize = "200"
            expect(temp.valid?).to eq(true)
            temp.fontSize = nil
            expect(temp.valid?).to eq(true)
        end
    end
    
    describe "Opacity validation" do
        it "only accepts value between 0 and 1.0" do
            temp = GroupCss.new()
            temp.opacity = 0.0
            expect(temp.valid?).to eq(true)
            temp.opacity = 1.0
            expect(temp.valid?).to eq(true)
            temp.opacity = -0.1
            expect(temp.valid?).to eq(false)
            temp.opacity = 1.1
            expect(temp.valid?).to eq(false)
            temp.opacity = nil
            expect(temp.valid?).to eq(true)
        end
    end
    
    describe "Border Radius validation" do
        it "only accepts value greater than or equal to 0" do
            temp = GroupCss.new()
            temp.borderRadius = "0"
            expect(temp.valid?).to eq(true)
            temp.borderRadius = "100"
            expect(temp.valid?).to eq(true)
            temp.borderRadius = "-1"
            expect(temp.valid?).to eq(false)
            temp.borderRadius = "200"
            expect(temp.valid?).to eq(true)
            temp.borderRadius = nil
            expect(temp.valid?).to eq(true)
        end
    end
    
    describe "Border Size validation" do
        it "only accepts value greater than or equal to 0" do
            temp = GroupCss.new()
            temp.borderSize = "0"
            expect(temp.valid?).to eq(true)
            temp.borderSize = "100"
            expect(temp.valid?).to eq(true)
            temp.borderSize = "-1"
            expect(temp.valid?).to eq(false)
            temp.borderSize = "200"
            expect(temp.valid?).to eq(true)
            temp.borderSize = nil
            expect(temp.valid?).to eq(true)
        end
    end
    
    describe "BoxShadow Validation" do
        it "accepts all of the positions in all_shadows" do
            temp = GroupCss.new()
            temp.save
            GroupCss.all_shadows_check.each do |shadow|
                temp.boxShadow = shadow
                expect(temp.valid?).to eq (true)
            end
        end
        it "Does not accept a position that is not in all_defaults" do
            temp = GroupCss.new()
            temp.boxShadow = "hahahaha"
            expect(temp.valid?).to eq(false)
        end
    end
    
    describe "Hover Validation" do
        it "accepts all of the positions in all_hovers" do
            temp = GroupCss.new()
            temp.save
            GroupCss.all_hovers_check.each do |hover|
                temp.hover = hover
                expect(temp.valid?).to eq (true)
            end
        end
        it "Does not accept a position that is not in all_shadows" do
            temp = GroupCss.new()
            temp.hover = "hahahaha"
            expect(temp.valid?).to eq(false)
        end
    end
    
    
    describe "get_static_nonstatic_proj_csses" do 
        it "returns the correct lists of static and nonstatic proj csses for the selected protfolio id and group id" do
            portfolio1 = Portfolio.all()[0]
            portfolio2 = Portfolio.all()[1]
            group1 = Group.all()[0]
            group2 = Group.all()[1]
            portfolio2 = Portfolio.all()[1]
            
            groupCssToEdit1 = GroupCss.where(:group_id => Group.find(1).id, :portfolio_id => portfolio2.id).take
            groupCssToEdit2 = GroupCss.where(:group_id => Group.find(2).id, :portfolio_id => portfolio2.id).take
            groupCssToEdit1.position = "absolute"
            groupCssToEdit1.save
            groupCssToEdit2.position = "static"
            groupCssToEdit2.save
            
            static, non_static = GroupCss.get_static_nonstatic_group_csses(portfolio2.id)
            static_expected = []
            non_static_expected = [groupCssToEdit1]
            
            expect(static).to eq(static_expected)
            expect(non_static).to eq(non_static_expected)
            
            
            
            groupCssToEdit1.position = "static"
            groupCssToEdit1.save
            groupCssToEdit2.position = "static"
            groupCssToEdit2.save
            static, non_static = GroupCss.get_static_nonstatic_group_csses(portfolio2.id)
            static_expected = [groupCssToEdit1]
            non_static_expected = []
            
            expect(static).to eq(static_expected)
            expect(non_static).to eq(non_static_expected)
            
            
            groupCssToEdit1.position = "static"
            groupCssToEdit1.visible = false
            groupCssToEdit1.save
            groupCssToEdit2.position = "static"
            groupCssToEdit2.save
            static, non_static = GroupCss.get_static_nonstatic_group_csses(portfolio2.id)
            
            expect(static).to eq([])
            expect(non_static).to eq([])
           
        end
        
    end
    
end