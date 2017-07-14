require 'rails_helper'
require 'spec_helper'
require 'rack/test'
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe PicturesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Picture. As you add validations to Picture, be sure to
  # adjust the attributes here as well.
  # let(:valid_attributes_picture){
  #   {:project_img=>File.new(Rails.root + 'spec/fixtures/images/rails.png')}
  # }
  
   let(:valid_user_1_attributes){
    {:email => "eric@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
  }
  
  # let(:valid_user_2_attributes){
  #   {:email => "eric2@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
  # }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PicturesController. Be sure to keep this updated too.
  # let(:valid_session) { {} }
   before(:each) do
    user1 = User.create valid_user_1_attributes
    group1 = Group.create(:name => "Group 1", :description => "First group created for eric")
    group2 = Group.create(:name => "Group 2", :description => "Second group created for eric")
    user1.groups << group1
    user1.groups << group2
    user1.save
    project1 = Proj.create(:name => "Project 1", :description => "First project created for eric")
    project2 = Proj.create(:name => "Project 2", :description => "Second project created for eric")
    project3 = Proj.create(:name => "Project 3", :description => "Third project created for eric")
    project4 = Proj.create(:name => "Project 4", :description => "Fourth project created for eric")
    user1.projs << project1
    user1.projs << project2
    user1.projs << project3
    user1.projs << project4

    project1.pictures << Picture.create(:project_img=>File.new('spec/fixtures/img1.jpg'))
    
    # @picture = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/img1.jpg'), 'image/jpg')
    
    
  end
  
  # def valid_attributes
  #     { "project_img" => @image}
  # end

  describe "GET #index" do
    it "assigns all pictures as @pictures" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      picture=project1.pictures
      get :index, {:project_id=>project1.id}
      expect(assigns(:pictures)).to eq(picture)
    end
  end

  describe "GET #show" do
    it "assigns the requested picture as @picture" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      picture=project1.pictures
      get :show, {:id=> picture[0].id}
      expect(assigns(:picture)).to eq(picture[0])
    end
  end

  describe "GET #new" do
    it "assigns a new picture as @picture" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      get :new, {:project_id=>project1.id}
      expect(assigns(:picture)).to be_a_new(Picture)
    end
  end

  describe "GET #edit" do
    it "assigns the requested picture as @picture" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      picture = project1.pictures[0]
      get :edit,{:id=>picture.id}
      expect(assigns(:picture)).to eq(picture)
    end
  end

  describe "POST #create" do
    # let(:update_attributes) { {
    #   'project_img'=>File.new('spec/fixtures/img1.jpg'),
    #   'project_id'=>'1'
    #   # 'html'=> {:multipart => true}
    # }}

    it "it create a new picture for current project" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      post :create, {:picture => {:project_img => Rack::Test::UploadedFile.new('spec/fixtures/img1.jpg','image/jpg'), :project_id => project1.id}}
      expect(assigns(:picture)).to be_a(Picture)
      # puts(assigns(:picture))
      # expect(controller.notice).to eq(nil)
      # expect {post :create, {:picture =>  { :project_img => Rack::Test::UploadedFile.new('spec/fixtures/img1.jpg'), :project_id => '1'}}}.to change(P, :count).by 1
      # expect(response).to redirect_to(pictures_path(:project_id=>project1.id))
    end
    it "cannot create a new picture with a invaild name" do 
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      post :create, {:picture =>  { :project_img => nil, :project_id => '1'}}
    end
    
  end


  describe "PUT #update" do
    # let(:new_attributes) { {
    #       'project_img'=>File.new('spec/fixtures/img1.jpg')
    #     }}
      let(:update_attributes) { {
          'picture'=>File.new('spec/fixtures/img1.jpg'),
          'project_id'=>'1',
          'html'=> {:multipart => true}
      }}
      let(:invaild_attributes) { {
          'project_img'=>nil,
          'project_id'=>'1',
          'html'=> {:multipart => true}
      }}
      it "can update a existing picture" do
          user1 = User.find_by_email("eric@eric.com")
          sign_in user1
          project1=user1.projs.find_by_name("Project 1")
          picture =project1.pictures[0]
          put :update,  {:id => picture.id, :picture => update_attributes}
          picture.reload
          expect(controller.notice).to eq('Picture was successfully updated.')
      end
      it "cannot update a existing picture" do
          user1 = User.find_by_email("eric@eric.com")
          sign_in user1
          project1=user1.projs.find_by_name("Project 1")
          picture =project1.pictures[0]
          put :update,  {:id => picture.id, :picture => invaild_attributes}
          picture.reload
      end
    end


  describe "DELETE #destroy" do
    it "destroys the requested picture" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      picture =project1.pictures[0]
      expect {
        delete :destroy, {:id=> picture.id}
      }.to change(Picture, :count).by(-1)
    end

    it "redirects to the pictures list" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      picture =project1.pictures[0]
      delete :destroy,  {:id=> picture.id}
      expect(response).to redirect_to(pictures_path(:project_id=>project1.id))
    end
  end

end