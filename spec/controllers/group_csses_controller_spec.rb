require 'rails_helper'

RSpec.describe GroupCssesController, type: :controller do
    
    # This should return the minimal set of attributes required to create a valid
    # Group. As you add validations to Group, be sure to
    # adjust the attributes here as well.
    
    let(:valid_user_1_attributes){
      {:email => "eric@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
    }
    
    let(:valid_user_2_attributes){
      {:email => "eric2@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
    }
    
    let(:valid_user_3_attributes){
      {:email => "eric3@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
    }
    
    before(:each) do
      
        user1 = User.create valid_user_1_attributes
        group1 = Group.create(:name => "Group 1", :description => "First group created for eric")
        group2 = Group.create(:name => "Group 2", :description => "Second group created for eric")
        group3 = Group.create(:name => "Group 3", :description => "Third group created for eric")
        group4 = Group.create(:name => "Group 4", :description => "Fourth group created for eric")
        user1.groups << group1
        user1.groups << group2
        user1.groups << group3
        user1.groups << group4
        user1.save
        portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric", :template => "")
        portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric", :template => "")
        user1.portfolios << portfolio1
        user1.portfolios << portfolio2
        user1.save
        portfolio1.groups << group1
        portfolio1.groups << group2
        portfolio1.groups << group3
        portfolio1.groups << group4
        portfolio2.groups << group1
        portfolio2.groups << group2
        portfolio2.groups << group3
        portfolio2.groups << group4
        #now assign the visibility.  Portfolio 1 is going to have all groups set to invisible
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group1.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group2.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group3.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group4.id).take
        tempCss.visible = false
        tempCss.save
        # now assign the visiblility.  Portfolio 2 is going to have half groups set to visible
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group1.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group2.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group3.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group4.id).take
        tempCss.visible = false
        tempCss.save
        
        ################################################################
        # Now create portfolios for user number 2
        ################################################################
        user2 = User.create valid_user_2_attributes
        group1 = Group.create(:name => "Group 1", :description => "First group created for eric2")
        group2 = Group.create(:name => "Group 2", :description => "Second group created for eric2")
        group3 = Group.create(:name => "Group 3", :description => "Third group created for eric2")
        group4 = Group.create(:name => "Group 4", :description => "Fourth group created for eric2")
        group5 = Group.create(:name => "Group 5", :description => "Fifth group created for eric2")
        group6 = Group.create(:name => "Group 6", :description => "Sixth group created for eric2")
        user2.groups << group1
        user2.groups << group2
        user2.groups << group3
        user2.groups << group4
        user2.groups << group5
        user2.groups << group6
        user2.save
        portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric2", :template => "")
        portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric2", :template => "")
        user2.portfolios << portfolio1
        user2.portfolios << portfolio2
        user2.save
        portfolio1.groups << group1
        portfolio1.groups << group2
        portfolio1.groups << group3
        portfolio1.groups << group4
        portfolio1.groups << group5
        portfolio1.groups << group6
        portfolio2.groups << group1
        portfolio2.groups << group2
        portfolio2.groups << group3
        portfolio2.groups << group4
        portfolio2.groups << group5
        portfolio2.groups << group6
        #now assign the visibility.  Portfolio # 1 is going to have only one project of each group visible
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group1.id).take
        tempCss.visible = true
        #tempCss.position = "absolute"
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group2.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group3.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group4.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group5.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group6.id).take
        tempCss.visible = true
        tempCss.save
        # now assign the visiblility.  Portfolio 2 is going to have all projects of all groups visible
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group1.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group2.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group3.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group4.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group5.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group6.id).take
        tempCss.visible = true
        tempCss.save
      
        ################################################################
        # Now create portfolios for user number 3
        ################################################################
        user3 = User.create valid_user_3_attributes
        group1 = Group.create(:name => "Group 1", :description => "First group created for eric2")
        group2 = Group.create(:name => "Group 2", :description => "Second group created for eric2")
        group3 = Group.create(:name => "Group 3", :description => "Third group created for eric2")
        group4 = Group.create(:name => "Group 4", :description => "Fourth group created for eric2")
        group5 = Group.create(:name => "Group 5", :description => "Fifth group created for eric2")
        group6 = Group.create(:name => "Group 6", :description => "Sixth group created for eric2")
        user3.groups << group1
        user3.groups << group2
        user3.groups << group3
        user3.groups << group4
        user3.groups << group5
        user3.groups << group6
        user3.save
        portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric2",:token => 'AD35707712', :template => "")
        portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric2", :token => 'EA0C41492B', :template => "")
        user3.portfolios << portfolio1
        user3.portfolios << portfolio2
        user3.save
        portfolio1.groups << group1
        portfolio1.groups << group2
        portfolio1.groups << group3
        portfolio1.groups << group4
        portfolio1.groups << group5
        portfolio1.groups << group6
        portfolio2.groups << group1
        portfolio2.groups << group2
        portfolio2.groups << group3
        portfolio2.groups << group4
        portfolio2.groups << group5
        portfolio2.groups << group6
        #now assign the visibility.  Portfolio # 1 is going to have only one project of each group visible
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group1.id).take
        tempCss.visible = true
        #tempCss.position = "absolute"
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group2.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group3.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group4.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group5.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio1.id, group_id: group6.id).take
        tempCss.visible = true
        tempCss.save
        # now assign the visiblility.  Portfolio 2 is going to have all projects of all groups visible
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group1.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group2.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group3.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group4.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group5.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = GroupCss.where(portfolio_id: portfolio2.id, group_id: group6.id).take
        tempCss.visible = true
        tempCss.save

    end
    
    
    describe "GET #show" do 
        it "assigns @csses, @visible_css, @visible_css_static, @visible_css_not_static, @portfolio, and @editing correctly" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            group1 = portfolio1.groups[0]
            #Set up the expected @css value
            expected_css = GroupCss.where(:portfolio_id => portfolio1.id)
            
            
            #Set up the expected visible_css values
            expected_visible_proj_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = []
            temp = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
            temp.position = "absolute"
            temp.save!
            GroupCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |group_css|
               if group_css.position == "static"
                  expected_visible_css_static << group_css 
               else
                   expected_visible_css_not_static << group_css
               end
            end
            
            get :show, {:portfolio_id => portfolio1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:csses)).to eq(expected_css)
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(response).to render_template('show')
        end
        
        it "assigns @visible_css_static and @visible_css_not_static correctly when none of the visible GroupCsses are static" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2
            expected_visible_css_not_static = []
            GroupCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |group_css|
               group_css.position = "absolute"
               group_css.save
               expected_visible_css_not_static << group_css
            end
            
            
            get :show, {:portfolio_id => portfolio1.id}
            expect(assigns(:visible_css_static)).to eq([])
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            
        end
        
        it "assigns @visible_css_not_static correctly when all of the GroupCsses are static" do 
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            expected_visible_css_static = []
            visible_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            visible_csses.each do |css|
                expected_visible_css_static << css
            end
            
            
            get :show, {:portfolio_id => portfolio1.id}
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq([])
        end
        
        it "assigns @csses, @visible_css, @visible_css_static, and @visible_css_not_static correctly when a non-'Colorful' template is selected" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            portfolio1.template = "Hawks"
            portfolio1.save
            group1 = portfolio1.groups[0]
            temp = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
            temp.position = "absolute"
            temp.save
            #Set up the expected @css value
            expected_css = ProjCss.setTemplate(GroupCss.where(:portfolio_id => portfolio1.id))
            
            #Set up the expected visible_css values
            expected_visible_group_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            get :show, {:portfolio_id => portfolio1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_group_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:css)).to eq(expected_css)
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(response).to render_template('show')
        end
        
        it "assigns @csses, @visible_css, @visible_css_static, and @visible_css_not_static correctly when the 'Colorful' template is selected" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            portfolio1.template = "Colorful"
            portfolio1.save
            group1 = portfolio1.groups[0]
            temp = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
            temp.position = "absolute"
            temp.save
            #Set up the expected @css value
            expected_css = ProjCss.setTemplate(GroupCss.where(:portfolio_id => portfolio1.id))
            
            #Set up the expected visible_css values
            expected_visible_group_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            
            get :show, {:portfolio_id => portfolio1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_group_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:css)).to eq(expected_css)
            #expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)  #This gets assigned randomly so it is hard to test its exact value
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(response).to render_template('show')
        end
        
        it "redirects to home page if user not logged in" do
            get :show, {:portfolio_id => 1, :group_id => 1}
            expect(response).to redirect_to("/users/sign_in")
        end
        
        it "redirects to home page if user is logged in, but attempts to access a portfolio they do not have access to" do
            user2 = User.find_by_email("eric2@eric.com")
            user1 = User.find_by_email("eric@eric.com")
            sign_in user2
            
            portfolio = user1.portfolios[0]
            group = portfolio.groups[0]
            
            get :show, {:portfolio_id => portfolio.id, :group_id => group.id}
            expect(response).to redirect_to("/")
            expect(flash[:error]).to eq('You are not authorized to view this page')
        end
    end
    
    describe "GET #edit" do 
        it "assigns @csses, @visible_css, @visible_css_static, @visible_css_not_static, @portfolio, and @editing correctly" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            group1 = portfolio1.groups[0]
            #Set up the expected @css value
            expected_css = GroupCss.where(:portfolio_id => portfolio1.id)
            
            #Set up the expected visible_css values
            expected_visible_group_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = []
            temp = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
            temp.position = "absolute"
            temp.save
            GroupCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |group_css|
               if group_css.position == "static"
                  expected_visible_css_static << group_css 
               else
                   expected_visible_css_not_static << group_css
               end
            end
            
            get :edit, {:portfolio_id => portfolio1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_group_csses)
            expect(assigns(:editing)).to eq(true)
            expect(assigns(:css)).to eq(expected_css)
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(assigns(:portfolio)).to eq(portfolio1)
            expect(response).to render_template('edit')
        end
        
        it "assigns @csses, @visible_css, @visible_css_static, and @visible_css_not_static correctly when randomStyle is selected" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            portfolio1.randomStyle = true
            portfolio1.save
            group1 = portfolio1.groups[0]
            temp = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
            temp.position = "absolute"
            temp.save
            #Set up the expected @css value
            expected_css = ProjCss.setTemplate(GroupCss.where(:portfolio_id => portfolio1.id))
            
            #Set up the expected visible_css values
            expected_visible_group_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            get :edit, {:portfolio_id => portfolio1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_group_csses)
            expect(assigns(:editing)).to eq(true)
            expect(assigns(:css)).to be_truthy
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(assigns(:portfolio)).to eq(portfolio1)
            expect(response).to render_template('edit')
        end
        
        it "assigns @defaults, @hovers, @shadows, @positions, and @fonts correctly" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            
            get :edit, {:portfolio_id => portfolio1.id}
            expect(assigns(:defaults)).to eq(GroupCss.all_defaults)
            expect(assigns(:hovers)).to eq(GroupCss.all_hovers)
            expect(assigns(:shadows)).to eq(GroupCss.all_shadows)
            expect(assigns(:positions)).to eq(GroupCss.all_positions)
            expect(assigns(:fonts)).to eq(GroupCss.all_fonts)
        end
        
        it "redirects to home page if user is logged in, but attempts to access a portfolio they do not have access to" do
            user2 = User.find_by_email("eric2@eric.com")
            user1 = User.find_by_email("eric@eric.com")
            sign_in user2
            
            portfolio = user1.portfolios[0]
            
            get :edit, {:portfolio_id => portfolio.id}
            expect(response).to redirect_to("/")
            expect(flash[:error]).to eq('You are not authorized to view this page')
        end
        
    end
    
    
    describe "PATCH #update" do
        it "Successfully saves valid updates to the database and redirects to the edit page" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => "1"}
            expect(GroupCss.find(group_csses[0].id).visible).to eq(true)
            expect(GroupCss.find(group_csses[1].id).visible).to eq(true)
            expect(GroupCss.find(group_csses[2].id).visible).to eq(true)
            expect(GroupCss.find(group_csses[3].id).visible).to eq(true)
            expect(response).to redirect_to("/portfolios/1/group_csses/edit")
            
            
        end
        
        it "redirects to home page if user is logged in, but attempts to modify a portfolio they do not have access to" do
            user2 = User.find_by_email("eric2@eric.com")
            user1 = User.find_by_email("eric@eric.com")
            sign_in user2
            
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"41", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => "1"}
            
            expect(GroupCss.find(group_csses[0].id).width).to eq("40")
            expect(response).to redirect_to("/")
            expect(flash[:error]).to eq('You are not authorized to view this page')
        end
        
        it "sets color, backgroundColor, height, and width to '' when a default style is selected" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"smallRed", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s()}
    
            expect(GroupCss.find(group_csses[0].id).defaultStyle).to eq("smallRed")
            expect(GroupCss.find(group_csses[0].id).color).to eq("")
            expect(GroupCss.find(group_csses[0].id).backgroundColor).to eq("")
            expect(GroupCss.find(group_csses[0].id).height).to eq("")
            expect(GroupCss.find(group_csses[0].id).width).to eq("")
            
        end
        
        it "sets color, backgroundColor, height, and width to '' when a default style is selected and hover is selected" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"smallRed", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>"hoverRed"}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s()}
    
            expect(GroupCss.find(group_csses[0].id).defaultStyle).to eq("smallRed")
            expect(GroupCss.find(group_csses[0].id).color).to eq("")
            expect(GroupCss.find(group_csses[0].id).backgroundColor).to eq("")
            expect(GroupCss.find(group_csses[0].id).height).to eq("")
            expect(GroupCss.find(group_csses[0].id).width).to eq("")
        end
        
        it "sets color and backgroundColor to '' when hover is selected" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>"hoverRed"}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s()}
    
            expect(GroupCss.find(group_csses[0].id).defaultStyle).to eq("")
            expect(GroupCss.find(group_csses[0].id).color).to eq("")
            expect(GroupCss.find(group_csses[0].id).backgroundColor).to eq("")
            expect(GroupCss.find(group_csses[0].id).height != "").to eq(true)
            expect(GroupCss.find(group_csses[0].id).width != "").to eq(true)
            
        end
        
        it "displays an error flash when invalid values are passed" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            temp = GroupCss.find(group_csses[0].id)
            temp.width = 40
            temp.save
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"200", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>"hoverRed"}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s()}
    
            expect(GroupCss.find(group_csses[0].id).width).to eq("40")
            expect(flash[:warning].include?("Update failed due to following errors:")).to eq(true)
            expect(flash[:warning].include?("Width must be less than or equal to 100.0")).to eq(true)
            
        end
        
        it "displays no error when the selected position is static and width + length is greater than 100" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            temp = GroupCss.find(group_csses[0].id)
            temp.width = 40
            temp.save
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"100", "height"=>"40", "top"=>"0", "left"=>"1", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>"hoverRed"}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s}
    
            expect(GroupCss.find(group_csses[0].id).width).to eq("100")
            expect(GroupCss.find(group_csses[0].id).left).to eq(1)
            expect(flash[:warning] == nil).to eq(true)
            expect(flash[:notice].include?("Settings updated successfully")).to eq(true)
        end
        
        it "displays an error when the selected position is non-static and width + length is greater than 100" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            temp = GroupCss.find(group_csses[0].id)
            temp.width = 40
            temp.save
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"absolute", "width"=>"100", "height"=>"40", "top"=>"0", "left"=>"1", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>"hoverRed"}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s}
    
            expect(GroupCss.find(group_csses[0].id).width).to eq("40")
            expect(GroupCss.find(group_csses[0].id).left).to eq(0)
            expect(flash[:warning].include?("Width + Left on non-static must be less than 100")).to eq(true)
            expect(flash[:notice] == nil).to eq(true)
        end
        
        it "displays both errors when the selected position is non-static and width + length is greater than 100 and there is another error in regular validation" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            group_csses = GroupCss.where(:portfolio_id => portfolio.id)
            temp = GroupCss.find(group_csses[0].id)
            temp.width = 40
            temp.save
            
            group_csses1 = {"id"=>group_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"absolute", "width"=>"100", "height"=>"40", "top"=>"0", "left"=>"1", "font"=>"Times New Roman", "fontSize"=>"-1", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>"hoverRed"}
            group_csses2 = {"id"=>group_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses3 = {"id"=>group_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses4 = {"id"=>group_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            group_csses_compilation = {("group_csses"+group_csses[0].id.to_s()) => group_csses1, ("group_csses"+group_csses[1].id.to_s()) => group_csses2, ("group_csses"+group_csses[2].id.to_s()) => group_csses3, ("group_csses"+group_csses[3].id.to_s()) => group_csses4}
            
            
            patch :update, {"portfolio"=> group_csses_compilation, "commit" => "Update Styling", "controller" => "group_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s}
    
            expect(GroupCss.find(group_csses[0].id).width).to eq("40")
            expect(GroupCss.find(group_csses[0].id).left).to eq(0)
            expect(GroupCss.find(group_csses[0].id).fontSize).to eq(100)
            expect(flash[:warning].include?("Width + Left on non-static must be less than 100")).to eq(true)
            expect(flash[:warning].include?("Fontsize must be greater than or equal to 0.0")).to eq(true)
            expect(flash[:notice] == nil).to eq(true)
        end
        
    end
    
    describe "#GET#show_group"
        it "should displays groups for a portfolio without login" do
            user3 = User.find_by_email("eric3@eric.com")
            sign_in user3
            portfolio1 = user3.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            group1 = portfolio1.groups[0]
            #Set up the expected @css value
            expected_css = GroupCss.where(:portfolio_id => portfolio1.id)
            
            
            #Set up the expected visible_css values
            expected_visible_proj_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = []
            temp = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
            temp.position = "absolute"
            temp.save
            GroupCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |group_css|
               if group_css.position == "static"
                  expected_visible_css_static << group_css 
               else
                   expected_visible_css_not_static << group_css
               end
            end
            
            sign_out user3
            get :show_group, {:token => portfolio1.token}
            expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:csses)).to eq(expected_css)
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
        
           
        end
        
        it "should displays groups for a portfolio without login when a non-'Colorful' template is selected" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            portfolio1.template = "Hawks"
            portfolio1.save
            group1 = portfolio1.groups[0]
            temp = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
            temp.position = "absolute"
            temp.save
            #Set up the expected @css value
            expected_css = ProjCss.setTemplate(GroupCss.where(:portfolio_id => portfolio1.id))
            
            #Set up the expected visible_css values
            expected_visible_group_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            sign_out user2
            get :show_group, {:token => portfolio1.token}
            expect(assigns(:visible_css)).to eq(expected_visible_group_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:csses)).to eq(expected_css)
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
        
           
        end
        
        it "should displays groups for a portfolio without login when a 'Colorful' template is selected" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            portfolio1.template = "Colorful"
            portfolio1.save
            group1 = portfolio1.groups[0]
            temp = GroupCss.where(:portfolio_id => portfolio1.id, :group_id => group1.id).take
            temp.position = "absolute"
            temp.save
            #Set up the expected @css value
            expected_css = ProjCss.setTemplate(GroupCss.where(:portfolio_id => portfolio1.id))
            
            #Set up the expected visible_css values
            expected_visible_group_csses = GroupCss.where(:portfolio_id => portfolio1.id, :visible => true)
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            
            
            sign_out user2
            get :show_group, {:token => portfolio1.token}
            expect(assigns(:visible_css)).to eq(expected_visible_group_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:csses)).to eq(expected_css)
            #expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)  #This gets assigned randomly so it is hard to test its exact value
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
        
           
        end
end