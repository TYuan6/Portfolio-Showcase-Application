require 'rails_helper'

RSpec.describe ProjCssesController, type: :controller do
    
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
        {:email => "eric2@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
    }
    
    before(:each) do
      
        user1 = User.create valid_user_1_attributes
        group1 = Group.create(:name => "Group 1", :description => "First group created for eric")
        group2 = Group.create(:name => "Group 2", :description => "Second group created for eric")
        user1.groups << group1
        user1.groups << group2
        user1.save
        portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric", :template => "")
        portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric", :template => "")
        user1.portfolios << portfolio1
        user1.portfolios << portfolio2
        user1.save
        project1 = Proj.create(:name => "Project 1", :description => "First project created for eric")
        project2 = Proj.create(:name => "Project 2", :description => "Second project created for eric")
        project3 = Proj.create(:name => "Project 3", :description => "Third project created for eric")
        project4 = Proj.create(:name => "Project 4", :description => "Fourth project created for eric")
        user1.projs << project1
        user1.projs << project2
        user1.projs << project3
        user1.projs << project4
        portfolio1.projs << project1
        portfolio1.projs << project2
        portfolio1.projs << project3
        portfolio1.projs << project4
        portfolio2.projs << project1
        portfolio2.projs << project2
        portfolio2.projs << project3
        portfolio2.projs << project4
        portfolio1.groups << group1
        portfolio1.groups << group2
        portfolio2.groups << group1
        portfolio2.groups << group2
        user1.groups[0].projs << project1
        user1.groups[0].projs << project2
        user1.groups[1].projs << project3
        user1.groups[1].projs << project4
        #now assign the visibility.  Portfolio 1 is going to have projects in group 1's visibility off and no projects part of group 2
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project1.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project2.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project3.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project4.id).take
        tempCss.visible = false
        tempCss.save
        # now assign the visiblility.  Portfolio 2 is going to have half the projects' visibility on and no projects part of group 2
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project1.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project2.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project3.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project4.id).take
        tempCss.visible = false
        tempCss.save
        
        ################################################################
        # Now create portfolios for user number 2
        ################################################################
        user2 = User.create valid_user_2_attributes
        group1 = Group.create(:name => "Group 1", :description => "First group created for eric2")
        group2 = Group.create(:name => "Group 2", :description => "Second group created for eric2")
        user2.groups << group1
        user2.groups << group2
        user2.save
        portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric2", :template => "")
        portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric2", :template => "")
        user2.portfolios << portfolio1
        user2.portfolios << portfolio2
        user2.save
        project1 = Proj.create(:name => "Project 1", :description => "First project created for eric2")
        project2 = Proj.create(:name => "Project 2", :description => "Second project created for eric2")
        project3 = Proj.create(:name => "Project 3", :description => "Third project created for eric2")
        project4 = Proj.create(:name => "Project 4", :description => "Fourth project created for eric2")
        project5 = Proj.create(:name => "Project 5", :description => "Fifth project created for eric2")
        project6 = Proj.create(:name => "Project 6", :description => "Sixth project created for eric2")
        user2.projs << project1
        user2.projs << project2
        user2.projs << project3
        user2.projs << project4
        user2.projs << project5
        user2.projs << project6
        portfolio1.projs << project1
        portfolio1.projs << project2
        portfolio1.projs << project3
        portfolio1.projs << project4
        portfolio1.projs << project5
        portfolio1.projs << project6
        portfolio2.projs << project1
        portfolio2.projs << project2
        portfolio2.projs << project3
        portfolio2.projs << project4
        portfolio2.projs << project5
        portfolio2.projs << project6
        portfolio1.groups << group1
        portfolio1.groups << group2
        portfolio2.groups << group1
        portfolio2.groups << group2
        user2.groups[0].projs << project1
        user2.groups[0].projs << project2
        user2.groups[0].projs << project3
        user2.groups[1].projs << project4
        user2.groups[1].projs << project5
        user2.groups[1].projs << project6
        #now assign the visibility.  Portfolio # 1 is going to have only one project of each group visible
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project1.id).take
        tempCss.visible = true
        #tempCss.position = "absolute"
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project2.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project3.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project4.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project5.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project6.id).take
        tempCss.visible = true
        tempCss.save
        # now assign the visiblility.  Portfolio 2 is going to have all projects of all groups visible
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project1.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project2.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project3.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project4.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project5.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project6.id).take
        tempCss.visible = true
        tempCss.save
       
       ################################################################
        # Now create portfolios for user number 3
        ################################################################
        user3 = User.create valid_user_3_attributes
        group1 = Group.create(:name => "Group 1", :description => "First group created for eric2")
        group2 = Group.create(:name => "Group 2", :description => "Second group created for eric2")
        user3.groups << group1
        user3.groups << group2
        user3.save
        portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric2", :token => 'AD35707712', :template => "")
        portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric2", :token => 'EA0C41492B', :template => "")
        user3.portfolios << portfolio1
        user3.portfolios << portfolio2
        user3.save
        project1 = Proj.create(:name => "Project 1", :description => "First project created for eric2")
        project2 = Proj.create(:name => "Project 2", :description => "Second project created for eric2")
        project3 = Proj.create(:name => "Project 3", :description => "Third project created for eric2")
        project4 = Proj.create(:name => "Project 4", :description => "Fourth project created for eric2")
        project5 = Proj.create(:name => "Project 5", :description => "Fifth project created for eric2")
        project6 = Proj.create(:name => "Project 6", :description => "Sixth project created for eric2")
        user2.projs << project1
        user2.projs << project2
        user2.projs << project3
        user2.projs << project4
        user2.projs << project5
        user2.projs << project6
        portfolio1.projs << project1
        portfolio1.projs << project2
        portfolio1.projs << project3
        portfolio1.projs << project4
        portfolio1.projs << project5
        portfolio1.projs << project6
        portfolio2.projs << project1
        portfolio2.projs << project2
        portfolio2.projs << project3
        portfolio2.projs << project4
        portfolio2.projs << project5
        portfolio2.projs << project6
        portfolio1.groups << group1
        portfolio1.groups << group2
        portfolio2.groups << group1
        portfolio2.groups << group2
        user2.groups[0].projs << project1
        user2.groups[0].projs << project2
        user2.groups[0].projs << project3
        user2.groups[1].projs << project4
        user2.groups[1].projs << project5
        user2.groups[1].projs << project6
        #now assign the visibility.  Portfolio # 1 is going to have only one project of each group visible
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project1.id).take
        tempCss.visible = true
        #tempCss.position = "absolute"
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project2.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project3.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project4.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project5.id).take
        tempCss.visible = false
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio1.id, proj_id: project6.id).take
        tempCss.visible = true
        tempCss.save
        # now assign the visiblility.  Portfolio 2 is going to have all projects of all groups visible
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project1.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project2.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project3.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project4.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project5.id).take
        tempCss.visible = true
        tempCss.save
        tempCss = ProjCss.where(portfolio_id: portfolio2.id, proj_id: project6.id).take
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
            expected_css = []
            ProjCss.where(:portfolio_id => portfolio1.id).each do |proj_css|
               if(proj_css.proj.group.id == group1.id)
                  expected_css << proj_css 
               end
            end
            
            #Set up the expected visible_css values
            expected_visible_proj_csses = []
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
                if proj_css.proj.group.id == group1.id
                    expected_visible_proj_csses << proj_css 
                end
            end
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = []
            project = Proj.where(:user_id => user2.id, :name => "Project 1").take
            temp = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project.id).take
            temp.position = "absolute"
            temp.save
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
               if proj_css.position == "static" && proj_css.proj.group.id.to_i() == group1.id.to_i()
                  expected_visible_css_static << proj_css 
               elsif proj_css.proj.group.id.to_i() == group1.id.to_i()
                   expected_visible_css_not_static << proj_css
               end
            end
            
            get :show, {:portfolio_id => portfolio1.id, :group_id => group1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:csses)).to eq(expected_css)
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(assigns(:portfolio)).to eq(portfolio1)
            expect(response).to render_template('show')
        end
        
        
        
        it "assigns @csses, @visible_css, @visible_css_static, @visible_css_not_static, @portfolio, and @editing correctly when non-'Colorful' template is selected" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            portfolio1.template = "Hawks"
            portfolio1.save
            group1 = portfolio1.groups[0]
            #Set up the expected @css value
            expected_css = []
            ProjCss.where(:portfolio_id => portfolio1.id).each do |proj_css|
               if(proj_css.proj.group.id == group1.id)
                  expected_css << proj_css 
               end
            end
            
            #Set up the expected visible_css values
            expected_visible_proj_csses = []
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
                if proj_css.proj.group.id == group1.id
                    expected_visible_proj_csses << proj_css 
                end
            end
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = []
            project = Proj.where(:user_id => user2.id, :name => "Project 1").take
            temp = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project.id).take
            temp.position = "absolute"
            temp.save
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
               if proj_css.proj.group.id.to_i() == group1.id.to_i()
                  expected_visible_css_static << proj_css 
               end
            end
            
            get :show, {:portfolio_id => portfolio1.id, :group_id => group1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:csses)).to eq(expected_css)
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(assigns(:portfolio)).to eq(portfolio1)
            expect(response).to render_template('show')
        end
        
        it "assigns @csses, @visible_css, @visible_css_static, @visible_css_not_static, @portfolio, and @editing correctly when 'Colorful' template is selected" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            portfolio1.template = "Colorful"
            portfolio1.save
            group1 = portfolio1.groups[0]
            #Set up the expected @css value
            expected_css = []
            ProjCss.where(:portfolio_id => portfolio1.id).each do |proj_css|
               if(proj_css.proj.group.id == group1.id)
                  expected_css << proj_css 
               end
            end
            
            #Set up the expected visible_css values
            expected_visible_proj_csses = []
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
                if proj_css.proj.group.id == group1.id
                    expected_visible_proj_csses << proj_css 
                end
            end
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = []
            project = Proj.where(:user_id => user2.id, :name => "Project 1").take
            temp = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project.id).take
            temp.position = "absolute"
            temp.save
            
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
               if proj_css.proj.group.id.to_i() == group1.id.to_i()
                  expected_visible_css_static << proj_css 
               end
            end
            
            get :show, {:portfolio_id => portfolio1.id, :group_id => group1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
            expect(assigns(:editing)).to eq(false)
            expect(assigns(:csses)).to eq(expected_css)
            expect(assigns(:visible_css_static).size == expected_visible_css_static.size).to be_truthy
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(assigns(:portfolio)).to eq(portfolio1)
            expect(response).to render_template('show')
        end
        
        it "assigns @visible_css_static and @visible_css_not_static correctly when none of the projCsses are static" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            group1 = portfolio1.groups[0]
            expected_visible_css_not_static = []
            visible_csses = ProjCss.where(:portfolio_id => portfolio1.id, :visible => true)
            visible_csses.each do |css|
                if css.proj.group.id.to_i() == group1.id.to_i()
                    css.position = "fixed"
                    css.save
                    expected_visible_css_not_static << css
                end
            end
            
            
            get :show, {:portfolio_id => portfolio1.id, :group_id => group1.id}
            expect(assigns(:visible_css_static)).to eq([])
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            
        end
        
        it "assigns @visible_css_not_static correctly when all of the projCsses are static" do 
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            group1 = portfolio1.groups[0]
            expected_visible_css_static = []
            visible_csses = ProjCss.where(:portfolio_id => portfolio1.id, :visible => true)
            visible_csses.each do |css|
                if css.proj.group.id.to_i() == group1.id.to_i()
                    expected_visible_css_static << css
                end
            end
            
            
            get :show, {:portfolio_id => portfolio1.id, :group_id => group1.id}
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq([])
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
            expected_css = []
            ProjCss.where(:portfolio_id => portfolio1.id).each do |proj_css|
               if(proj_css.proj.group.id == group1.id)
                  expected_css << proj_css 
               end
            end
            
            #Set up the expected visible_css values
            expected_visible_proj_csses = []
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
                if proj_css.proj.group.id == group1.id
                    expected_visible_proj_csses << proj_css 
                end
            end
            
            #Set up the expected visible_css_not_static and visible_css_static values
            expected_visible_css_not_static = []
            expected_visible_css_static = []
            project = Proj.where(:user_id => user2.id, :name => "Project 1").take
            temp = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project.id).take
            temp.position = "absolute"
            temp.save
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
               if proj_css.position == "static" && proj_css.proj.group.id.to_i() == group1.id.to_i()
                  expected_visible_css_static << proj_css 
               elsif proj_css.proj.group.id.to_i() == group1.id.to_i()
                   expected_visible_css_not_static << proj_css
               end
            end
            
            get :edit, {:portfolio_id => portfolio1.id, :group_id => group1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
            expect(assigns(:editing)).to eq(true)
            expect(assigns(:css)).to eq(expected_css)
            expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
            expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
            expect(assigns(:portfolio)).to eq(portfolio1)
            expect(response).to render_template('edit')
        end
        
        
        it "assigns @csses, @visible_css, @visible_css_static, @visible_css_not_static, @portfolio, and @editing correctly when randomStyle is selected" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            portfolio1.randomStyle = true
            portfolio1.save
            group1 = portfolio1.groups[0]
            
            
            #Set up the expected visible_css values
            expected_visible_proj_csses = []
            ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
                if proj_css.proj.group.id == group1.id
                    expected_visible_proj_csses << proj_css 
                end
            end
            
            get :edit, {:portfolio_id => portfolio1.id, :group_id => group1.id}
            expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
            expect(assigns(:editing)).to eq(true)
            expect(assigns(:css).size).to eq(3)
            expect(assigns(:visible_css_static).size).to eq(2)  #These are randomly defined so have to make sure they exist with the appropriate amount of indeces
            expect(assigns(:visible_css_not_static)).to eq([])
            expect(assigns(:portfolio)).to eq(portfolio1)
            expect(assigns(:randomStyle)).to eq(true)
            expect(response).to render_template('edit')
        end
        
        it "assigns @defaults, @hovers, @shadows, @positions, and @fonts correctly" do
            user2 = User.find_by_email("eric2@eric.com")
            sign_in user2
            portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
            group1 = portfolio1.groups[0]
            
            get :edit, {:portfolio_id => portfolio1.id, :group_id => group1.id}
            expect(assigns(:defaults)).to eq(ProjCss.all_defaults)
            expect(assigns(:hovers)).to eq(ProjCss.all_hovers)
            expect(assigns(:shadows)).to eq(ProjCss.all_shadows)
            expect(assigns(:positions)).to eq(ProjCss.all_positions)
            expect(assigns(:fonts)).to eq(ProjCss.all_fonts)
        end
        
        it "redirects to home page if user is logged in, but attempts to access a portfolio they do not have access to" do
            user2 = User.find_by_email("eric2@eric.com")
            user1 = User.find_by_email("eric@eric.com")
            sign_in user2
            
            portfolio = user1.portfolios[0]
            group = portfolio.groups[0]
            
            get :edit, {:portfolio_id => portfolio.id, :group_id => group.id}
            expect(response).to redirect_to("/")
            expect(flash[:error]).to eq('You are not authorized to view this page')
        end
        
    end
    
    
    describe "PATCH #update" do
        it "Successfully saves valid updates to the database and redirects to the " do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => "1", "group_id" => "1"}
            expect(ProjCss.find(proj_csses[0].id).visible).to eq(true)
            expect(ProjCss.find(proj_csses[1].id).visible).to eq(true)
            expect(ProjCss.find(proj_csses[2].id).visible).to eq(true)
            expect(ProjCss.find(proj_csses[3].id).visible).to eq(true)
            expect(response).to redirect_to("/portfolios/1/proj_csses/1/edit")
            
        end
        
        it "redirects to home page if user is logged in, but attempts to modify a portfolio they do not have access to" do
            user2 = User.find_by_email("eric2@eric.com")
            user1 = User.find_by_email("eric@eric.com")
            sign_in user2
            
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s(), "group_id" => "1"}
    
            expect(response).to redirect_to("/")
            expect(flash[:error]).to eq('You are not authorized to view this page')
        end
        
        it "sets color, backgroundColor, height, and width to '' when a default style is selected" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"smallRed", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s(), "group_id" => "1"}
    
            expect(ProjCss.find(proj_csses[0].id).defaultStyle).to eq("smallRed")
            expect(ProjCss.find(proj_csses[0].id).color).to eq("")
            expect(ProjCss.find(proj_csses[0].id).backgroundColor).to eq("")
            expect(ProjCss.find(proj_csses[0].id).height).to eq("")
            expect(ProjCss.find(proj_csses[0].id).width).to eq("")
        end
        
        it "sets color, backgroundColor, height, and width to '' when a default style is selected and hover is selected" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"smallRed", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>"hoverRed"}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s(), "group_id" => "1"}
    
            expect(ProjCss.find(proj_csses[0].id).defaultStyle).to eq("smallRed")
            expect(ProjCss.find(proj_csses[0].id).color).to eq("")
            expect(ProjCss.find(proj_csses[0].id).backgroundColor).to eq("")
            expect(ProjCss.find(proj_csses[0].id).height).to eq("")
            expect(ProjCss.find(proj_csses[0].id).width).to eq("")
        end
        
        it "sets color and backgroundColor to '' when hover is selected" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>"hoverRed"}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s(), "group_id" => "1"}
    
            expect(ProjCss.find(proj_csses[0].id).defaultStyle).to eq("")
            expect(ProjCss.find(proj_csses[0].id).color).to eq("")
            expect(ProjCss.find(proj_csses[0].id).backgroundColor).to eq("")
            expect(ProjCss.find(proj_csses[0].id).height != "").to eq(true)
            expect(ProjCss.find(proj_csses[0].id).width != "").to eq(true)
            
        end
        
        it "displays an error flash when invalid values are passed" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            temp = ProjCss.find(proj_csses[0].id)
            temp.width = 40
            temp.save
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"200", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>"hoverRed"}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s(), "group_id" => "1"}
    
            expect(ProjCss.find(proj_csses[0].id).width).to eq("40")
            expect(flash[:warning].include?("Update failed due to following errors:")).to eq(true)
            expect(flash[:warning].include?("Width must be less than or equal to 100.0")).to eq(true)
            
        end
        
        it "displays no error when the selected position is static and width + length is greater than 100" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            temp = ProjCss.find(proj_csses[0].id)
            temp.width = 40
            temp.save
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"100", "height"=>"40", "top"=>"0", "left"=>"1", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>"hoverRed"}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s(), "group_id" => "1"}
    
            expect(ProjCss.find(proj_csses[0].id).width).to eq("100")
            expect(ProjCss.find(proj_csses[0].id).left).to eq(1)
            expect(flash[:warning] == nil).to eq(true)
            expect(flash[:notice].include?("Settings updated successfully")).to eq(true)
        end
        
        it "displays an error when the selected position is non-static and width + length is greater than 100" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            temp = ProjCss.find(proj_csses[0].id)
            temp.width = 40
            temp.save
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"fixed", "width"=>"100", "height"=>"40", "top"=>"0", "left"=>"1", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>"hoverRed"}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s(), "group_id" => "1"}
    
            expect(ProjCss.find(proj_csses[0].id).width).to eq("40")
            expect(ProjCss.find(proj_csses[0].id).left).to eq(0)
            expect(flash[:warning].include?("Width + Left on non-static must be less than 100")).to eq(true)
            expect(flash[:notice] == nil).to eq(true)
        end
        
        it "displays both errors when the selected position is non-static and width + length is greater than 100 and there is another error in regular validation" do
            user1 = User.find_by_email("eric@eric.com")
            sign_in user1
            
            portfolio = user1.portfolios[0]
            proj_csses = ProjCss.where(:portfolio_id => portfolio.id)
            temp = ProjCss.find(proj_csses[0].id)
            temp.width = 40
            temp.save
            
            proj_csses1 = {"id"=>proj_csses[0].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"fixed", "width"=>"100", "height"=>"40", "top"=>"0", "left"=>"1", "font"=>"Times New Roman", "fontSize"=>"-1", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>"hoverRed"}
            proj_csses2 = {"id"=>proj_csses[1].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses3 = {"id"=>proj_csses[2].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses4 = {"id"=>proj_csses[3].id.to_s(), "visible"=>"1", "background"=>"0", "defaultStyle"=>"", "position"=>"static", "width"=>"40", "height"=>"40", "top"=>"0", "left"=>"0", "font"=>"Times New Roman", "fontSize"=>"100", "color"=>"#000000", "backgroundColor"=>"#ffffff", "opacity"=>"1.0", "borderRadius"=>"2", "borderColor"=>"#000000", "borderSize"=>"4", "boxShadow"=>"shadowRed", "hover"=>""}
            proj_csses_compilation = {("proj_csses"+proj_csses[0].id.to_s()) => proj_csses1, ("proj_csses"+proj_csses[1].id.to_s()) => proj_csses2, ("proj_csses"+proj_csses[2].id.to_s()) => proj_csses3, ("proj_csses"+proj_csses[3].id.to_s()) => proj_csses4}
            
            
            patch :update, {"portfolio"=> proj_csses_compilation, "commit" => "Update Styling", "controller" => "proj_csses", "action" => "update", "portfolio_id" => portfolio.id.to_s(), "group_id" => "1"}
    
            expect(ProjCss.find(proj_csses[0].id).width).to eq("40")
            expect(ProjCss.find(proj_csses[0].id).left).to eq(0)
            expect(ProjCss.find(proj_csses[0].id).fontSize).to eq(100)
            expect(flash[:warning].include?("Width + Left on non-static must be less than 100")).to eq(true)
            expect(flash[:warning].include?("Fontsize must be greater than or equal to 0.0")).to eq(true)
            expect(flash[:notice] == nil).to eq(true)
        end
        
    end
    
         
    describe "GET #show_project" do 
      it "allow people to view projects belong to a portfolio without login" do
          user3 = User.find_by_email("eric2@eric.com")
          sign_in user3
          portfolio1 = user3.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
          group1 = portfolio1.groups[0]
          #Set up the expected @css value
          expected_css = []
          ProjCss.where(:portfolio_id => portfolio1.id).each do |proj_css|
             if(proj_css.proj.group.id == group1.id)
                expected_css << proj_css 
             end
          end
          
          #Set up the expected visible_css values
          expected_visible_proj_csses = []
          ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
              if proj_css.proj.group.id == group1.id
                  expected_visible_proj_csses << proj_css 
              end
          end
          
          #Set up the expected visible_css_not_static and visible_css_static values
          expected_visible_css_not_static = []
          expected_visible_css_static = []
          project = Proj.where(:user_id => user3.id, :name => "Project 1").take
          temp = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project.id).take
          temp.position = "absolute"
          temp.save
          ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
             if proj_css.position == "static" && proj_css.proj.group.id.to_i() == group1.id.to_i()
                expected_visible_css_static << proj_css 
             elsif proj_css.proj.group.id.to_i() == group1.id.to_i()
                 expected_visible_css_not_static << proj_css
             end
          end
          
          sign_out user3
          get :show_project, {:token => portfolio1.token, :format => group1.id}
          expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
          expect(assigns(:csses)).to eq(expected_css)
          expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
          expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
          expect(assigns(:portfolio)).to eq(portfolio1)
         
      end
      
      it "allow people to view projects belong to a portfolio without login with non-'Colorful' template" do
          user2 = User.find_by_email("eric2@eric.com")
          sign_in user2
          portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 2, group 1 because half of its projects are not visible
          portfolio1.template = "Hawks"
          portfolio1.save
          group1 = portfolio1.groups[0]
          #Set up the expected @css value
          expected_css = []
          ProjCss.where(:portfolio_id => portfolio1.id).each do |proj_css|
             if(proj_css.proj.group.id == group1.id)
                expected_css << proj_css 
             end
          end
          
          #Set up the expected visible_css values
          expected_visible_proj_csses = []
          ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
              if proj_css.proj.group.id == group1.id
                  expected_visible_proj_csses << proj_css 
              end
          end
          
          #Set up the expected visible_css_not_static and visible_css_static values
          expected_visible_css_not_static = []
          expected_visible_css_static = []
          project = Proj.where(:user_id => user2.id, :name => "Project 1").take
          temp = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project.id).take
          temp.position = "absolute"
          temp.save
          
          ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
             if proj_css.proj.group.id.to_i() == group1.id.to_i()
                expected_visible_css_static << proj_css 
             end
          end
          
          sign_out user2
          get :show_project, {:token => portfolio1.token, :format => group1.id}
          expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
          expect(assigns(:csses)).to eq(expected_css)
          expect(assigns(:visible_css_static)).to eq(expected_visible_css_static)
          expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
          expect(assigns(:portfolio)).to eq(portfolio1)
         
      end
      
      it "allow people to view projects belong to a portfolio without login with 'Colorful' template" do
          user2 = User.find_by_email("eric2@eric.com")
          sign_in user2
          portfolio1 = user2.portfolios[0]  #We are going to use Portfolio 1, group 1 because half of its projects are not visible
          portfolio1.template = "Colorful"
          portfolio1.save
          group1 = portfolio1.groups[0]
          #Set up the expected @css value
          expected_css = []
          ProjCss.where(:portfolio_id => portfolio1.id).each do |proj_css|
             if(proj_css.proj.group.id == group1.id)
                expected_css << proj_css 
             end
          end
          
          #Set up the expected visible_css values
          expected_visible_proj_csses = []
          ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
              if proj_css.proj.group.id == group1.id
                  expected_visible_proj_csses << proj_css 
              end
          end
          
          #Set up the expected visible_css_not_static and visible_css_static values
          expected_visible_css_not_static = []
          expected_visible_css_static = []
          project = Proj.where(:user_id => user2.id, :name => "Project 1").take
          temp = ProjCss.where(:portfolio_id => portfolio1.id, :proj_id => project.id).take
          temp.position = "absolute"
          temp.save
          
          ProjCss.where(:portfolio_id => portfolio1.id, :visible => true).each do |proj_css|
             if proj_css.proj.group.id.to_i() == group1.id.to_i()
                expected_visible_css_static << proj_css 
             end
          end
          
          sign_out user2
          get :show_project, {:token => portfolio1.token, :format => group1.id}
          expect(assigns(:visible_css)).to eq(expected_visible_proj_csses)
          expect(assigns(:csses)).to eq(expected_css)
          expect(assigns(:visible_css_static).size).to eq(expected_visible_css_static.size)  #This contains randomly generated
          expect(assigns(:visible_css_not_static)).to eq(expected_visible_css_not_static)
          expect(assigns(:portfolio)).to eq(portfolio1)
         
      end
  end
end