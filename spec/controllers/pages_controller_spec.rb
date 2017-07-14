require 'spec_helper'
require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Group. As you add validations to Group, be sure to
  # adjust the attributes here as well.
  
  let(:valid_user_1_attributes){
    {:email => "eric@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
  }
  

  before(:each) do
    
    user1 = User.create valid_user_1_attributes
    group1 = Group.create(:name => "Group 1", :description => "First group created for eric")
    group2 = Group.create(:name => "Group 2", :description => "Second group created for eric")
    user1.groups << group1
    user1.groups << group2
    user1.save
    portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric", :public_view => true)
    portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric", :public_view => false)
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
    user1.groups[0].projs << project1
    user1.groups[0].projs << project2
    user1.groups[0].projs << project3
    user1.groups[0].projs << project4
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
  end



  describe 'pages_home_path' do
    it "should redirect if not logged in" do
      get :home
      expect(response).to have_http_status(:redirect)
    end
    it "it should be routed to login if not logged in" do
      get :home
      expect(response).to redirect_to(new_user_session_path)
    end
    it "should have valid http status if logged in" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:user_signed_in?).and_return(true)
      user = User.create
      get :home
      expect(response).to have_http_status(:success)
    end
    it "it should be routed to home if logged in" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:user_signed_in?).and_return(true)
      user = User.create
      get :home
      expect(response).to render_template('pages/home')
    end
  end
  
  ################################################################
  
  describe 'pages_about_path' do
    it "GET #about path valid" do
      get :about
      expect(response).to have_http_status(:success)
    end
    it "GET #about routed correctly" do
      get :about
      expect(response).to render_template('pages/about')
    end
  end
  
  ################################################################
  
  describe 'pages_styles_path' do
    it "GET #styles path valid" do
      get :styles
      expect(response).to have_http_status(:success)
    end
    it "GET #styles routed correctly" do
      get :styles
      expect(response).to render_template('pages/styles')
    end
  end
  

###########################################################

  describe 'pages_publicPortfolios_path' do
    
    
    it "GET #publicPortfolios path valid" do
      get :publicPortfolios
      expect(response).to have_http_status(:success)
    end
    
    it "GET #publicPortfolios routed correctly" do
      get :publicPortfolios
      expect(response).to render_template('pages/publicPortfolios')
    end
    
    
    it "Can search portfolios with Portfolio name" do
      user = User.find_by_email("eric@eric.com")
      sign_in user
      portfolio1 = user.portfolios[0]  
      get :publicPortfolios, {:search => 'Portfolio 1'}
      expect(assigns(:publicPortfolios)[0]).to eq(portfolio1)
    end
    
    
    it "Can search portfolios with User email" do
      user = User.find_by_email("eric@eric.com")
      sign_in user
      portfolio1 = user.portfolios[0]  
      get :publicPortfolios, {:search => 'eric@eric.com'}
      expect(assigns(:publicPortfolios)[0]).to eq(portfolio1)
      
    end
    
  end
  
    describe "test helper function for getting user name by portfolio " do
      it "gets user name by portfolio" do
        user = User.find_by_email("eric@eric.com")
        sign_in user
        portfolio1 = user.portfolios[0]
        #subject.getUserName(portfolio1).should == 'Eric'
        expect(subject.getUserName(portfolio1)).to eq('Eric')
      end
    end
end
