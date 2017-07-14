require 'spec_helper'
require 'rails_helper'
require 'rack/test'

describe ProjsController do

  let(:valid_user_1_attributes){
    {:email => "eric@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold",
     :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
  }

  let(:valid_user_2_attributes){
    {:email => "eric2@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold",
     :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
  }

  let(:valid_user_3_attributes){
    {:email => "eric3@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold",
     :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
  }

  before(:each) do

    # create user1 and its groups
    user1 = User.create valid_user_1_attributes
    group1 = Group.create(:name => "Group 1", :description => "First group created for eric")
    group2 = Group.create(:name => "Group 2", :description => "Second group created for eric")
    user1.groups << group1
    user1.groups << group2
    user1.save
    user2 = User.create valid_user_2_attributes
    user3 = User.create valid_user_3_attributes
    portfolio1 = Portfolio.create(:name => "Portfolio 1", :description => "First portfolio created for eric")
    portfolio2 = Portfolio.create(:name => "Portfolio 2", :description => "Second portfolio created for eric")
    user1.portfolios << portfolio1
    user1.portfolios << portfolio2

  end


  describe 'Create a project: ' do
    it 'should add a project successfully' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      expect(flash[:notice]).to eq('Project ABC is successfully created.')
    end

    it 'should give hint information if there is no group' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      user1.groups.destroy_all
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      expect(flash[:warning]).to eq('You must first create groups then to create projects.')

    end

    it 'should add a project succesfully as begin time previous to end time in month distinctive' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"4",
                          "begin_date(3i)"=>"4", "end_date(1i)"=>"2014", "end_date(2i)"=>"5", "end_date(3i)"=>"4", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      expect(flash[:notice]).to eq('Project ABC is successfully created.')
    end

    it 'should add a project succesfully as begin time same with end time' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"4",
                          "begin_date(3i)"=>"4", "end_date(1i)"=>"2014", "end_date(2i)"=>"4", "end_date(3i)"=>"4", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      expect(flash[:notice]).to eq('Project ABC is successfully created.')
    end

    it 'should add a project unsuccesfully as begin time previous to end time in month distinctive' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"5",
                          "begin_date(3i)"=>"4", "end_date(1i)"=>"2014", "end_date(2i)"=>"4", "end_date(3i)"=>"4", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      post :create, params
      expect(flash[:warning]).to eq('Project begin date must be previous to the end date. Please try again.')
    end

    it 'should add a project unsuccesfully as begin time previous to end time in day distinctive' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"4",
                          "begin_date(3i)"=>"5", "end_date(1i)"=>"2014", "end_date(2i)"=>"4", "end_date(3i)"=>"4", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      post :create, params
      expect(flash[:warning]).to eq('Project begin date must be previous to the end date. Please try again.')
    end


    it 'should return to root_path if user does not signin' do
      user1 = User.find_by_email("eric@eric.com")
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      expect(response).to redirect_to(user_session_path)
    end

    it 'should check the project name distinctive' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      post :create, params
      expect(flash[:warning]).to eq('Your project name must be distinctive.')
    end

    it 'should check the project name not empty' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      post :create, params
      expect(flash[:warning]).to eq('Project name is required. Please try again.')
    end

    it 'cannot create a project due to the invalid image file type' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"4",
                          "begin_date(3i)"=>"4", "end_date(1i)"=>"2014", "end_date(2i)"=>"5", "end_date(3i)"=>"4", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>"","proj_icon"=>Rack::Test::UploadedFile.new('spec/fixtures/img1.jpg','text/plain')},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      expect(flash[:warning]).to eq('Icon should be image file. Please try again.')
    end

  end

  describe 'Edit a project: ' do
      it 'should modify a project property ' do
        user1 = User.find_by_email("eric@eric.com")
        sign_in user1
        params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                            "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                   "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
        post :create, params
        params = {"_method"=>"put",
                  "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                           "end_date(1i)"=>"2016", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>""},
                  "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
        put :update, params
        expect(flash[:notice]).to eq('Project ABC was successfully updated.')
      end

      it 'should check date validility' do
        user1 = User.find_by_email("eric@eric.com")
        sign_in user1
        params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                            "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                   "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
        post :create, params
        params = {"_method"=>"put",
                  "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                           "end_date(1i)"=>"2010", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>""},
                  "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
        @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
        put :update, params
        expect(flash[:warning]).to eq('Project begin date must be previous to the end date. Please try again.')
      end

      it 'should show unauthorization information if user is unlogged in' do
        user1 = User.find_by_email("eric@eric.com")
        params = {"_method"=>"put",
                  "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                           "end_date(1i)"=>"2010", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>""},
                  "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
        put :update, params
        expect(response).to redirect_to(user_session_path)
      end

      it 'should show unauthorization information if user tries to enter edit UI' do
        user1 = User.find_by_email("eric@eric.com")
        params = {"_method"=>"put",
                  "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                           "end_date(1i)"=>"2010", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>""},
                  "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
        get :edit, {:id => 1}
        expect(response).to redirect_to(user_session_path)
      end

      it 'should normaly show edit UI with previous configed properties' do
        user1 = User.find_by_email("eric@eric.com")
        sign_in user1
        params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                            "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>"",
                            "collaborator_emails" =>""},
                   "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
        post :create, params
        get :edit,{:id => "#{user1.projs.first.id}"}
        expect(response).to render_template('edit')
      end

      it 'cannot update a project due to the invalid image file type' do
        user1 = User.find_by_email("eric@eric.com")
        sign_in user1
        params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                            "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                   "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
        post :create, params
        params = {"_method"=>"put",
                  "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                           "end_date(1i)"=>"2016", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>"","proj_icon"=>Rack::Test::UploadedFile.new('spec/fixtures/img1.jpg','text/plain')},
                  "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
        put :update, params
        expect(flash[:warning]).to eq('Icon should be image file. Please try again.')
      end

  end

  describe "Edit project collaborator" do
    it "should check illegal emails address of collaborator" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      params = {"_method"=>"put",
                "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                         "end_date(1i)"=>"2016", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>"error email adress"},
                "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      put :update, params
      expect(flash[:warning]).to eq('There are illegal or repeated emails of collaborators, or an email is not in the our system account. Please check it again.')
    end

    it "should check repeated emails address of collaborator" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      params = {"_method"=>"put",
                "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                         "end_date(1i)"=>"2016", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>"abc2@abc.com;abc2@abc.com;"},
                "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      put :update, params
      expect(flash[:warning]).to eq('There are illegal or repeated emails of collaborators, or an email is not in the our system account. Please check it again.')
    end


    it "should support multiple emails address of collaborator" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      params = {"_method"=>"put",
                "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                         "end_date(1i)"=>"2016", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>"eric2@eric.com; eric3@eric.com"},
                "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      put :update, params
      expect(flash[:notice]).to eq('Project ABC was successfully updated. And copied ABC to "eric2@eric.com", "eric3@eric.com".')
    end

    it "should not create sharing project when target user has same project" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      sign_out user1

      user2 = User.find_by_email("eric2@eric.com")
      sign_in user2
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      params = {"_method"=>"put",
                "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                         "end_date(1i)"=>"2016", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>"eric@eric.com; eric3@eric.com"},
                "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/projs'
      put :update, params
      expect(flash[:notice]).to eq('Project ABC was successfully updated. And copied ABC to "eric3@eric.com".')
    end



  end

  describe 'delete a project: ' do
    it 'should delete a project successfully' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      delete :destroy, {:id => "#{user1.projs.first.id}"}
      expect(flash[:notice]).to eq('A project was deleted successfully.')
    end

    it 'should show unauthorization information if user is unlogged in' do
      user1 = User.find_by_email("eric@eric.com")
      delete :destroy, {:id => 1}
      expect(response).to redirect_to(user_session_path)
    end

  end

  describe 'Show a project: ' do
    it 'should show a project successfully' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>"",
                          "proj_icon"=>Rack::Test::UploadedFile.new('spec/fixtures/img1.jpg','image/jpg')},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params

      video1 = Video.create(:title => "Video1", :link =>"https://youtu.be/OvjAjb0Dp34")
      video2 = Video.create(:title => "Video2", :link =>"http://techslides.com/demos/sample-videos/small.mp4")
      video3 = Video.create(:title => "Video2", :link =>"http://techslides.com/demos/sample-videos/small.ogv")
      user1.projs.first.videos << video1
      user1.projs.first.videos << video2
      user1.projs.first.videos << video3
      get :show, {:id => "#{user1.projs.first.id}"}
      expect(response).to render_template('show')
    end

    it 'should show unauthorization information if user is unlogged in' do
      user1 = User.find_by_email("eric@eric.com")
      get :show, {:id => 1}
      expect(response).to redirect_to(user_session_path)
    end


    it "should return unknow group ID when target use does not have this group" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params
      params = {"_method"=>"put",
                "proj"=>{"name"=>"ABC", "description"=>"fdaXXXXX", "impact"=>"adfgsXXXXXX", "keywords"=>"", "begin_date(1i)"=>"2014", "begin_date(2i)"=>"11", "begin_date(3i)"=>"6",
                         "end_date(1i)"=>"2016", "end_date(2i)"=>"11", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "collaborator_emails" =>"eric2@eric.com; eric3@eric.com"},
                "commit"=>"Update this project", "controller"=>"projs", "action"=>"update", "id"=>"1"}
      put :update, params
      sign_out user1

      user2 = User.find_by_email("eric2@eric.com")
      sign_in user2
      get :show, {:id => "#{user2.projs.first.id}"}
      expect(response).to render_template('show')
      
    end

  end

  describe 'list projects: ' do
    it 'should list all projects' do
       user1 = User.find_by_email("eric@eric.com")
       sign_in user1
       get :index
       expect(response).to render_template('index')
    end

    it 'should show unauthorization information if user is unlogged in' do
      user1 = User.find_by_email("eric@eric.com")
      get :index
      expect(response).to redirect_to(user_session_path)
    end

  end

  describe 'new a project: ' do
    it 'should show new project view' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      get :new
      expect(response).to render_template('new')
    end

    it 'should show unauthorization information if user is unlogged in' do
      user1 = User.find_by_email("eric@eric.com")
      get :new
      expect(response).to redirect_to(user_session_path)
    end

  end
  
  describe 'Show a project in a shared link without user loggin : ' do
    it 'should show a project successfully without user loggin ' do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      params =  {"proj"=>{"name"=>"ABC", "description"=>"fad", "impact"=>"gad", "keywords"=>"afdsaf", "begin_date(1i)"=>"2012", "begin_date(2i)"=>"11",
                          "begin_date(3i)"=>"6", "end_date(1i)"=>"2016", "end_date(2i)"=>"10", "end_date(3i)"=>"6", "group_id"=>"Group 1", "link"=>"", "pictures"=>"", "video"=>""},
                 "commit"=>"Create this project", "controller"=>"projs", "action"=>"create"}
      post :create, params

      video1 = Video.create(:title => "Video1", :link =>"https://youtu.be/OvjAjb0Dp34")
      video2 = Video.create(:title => "Video2", :link =>"http://techslides.com/demos/sample-videos/small.mp4")
      video3 = Video.create(:title => "Video2", :link =>"http://techslides.com/demos/sample-videos/small.ogv")
      user1.projs.first.videos << video1
      user1.projs.first.videos << video2
      user1.projs.first.videos << video3
      
      sign_out user1
      get :show_project_show, {:token => 'A',  :format => "#{user1.projs.first.id}"}
      expect(response).to render_template('show_project_show')
    end
  end
end