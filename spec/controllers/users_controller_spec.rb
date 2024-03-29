require 'spec_helper'

describe UsersController do
  
  render_views
  
  describe "GET 'show'" do
    before(:each) do
      @user=FactoryGirl.create(:user)
    end
   it "returns http success" do
      get :show, :id=>@user.id
      response.should be_success
    end
    it "should ind the right user" do
      get :show, :id=>@user
      assigns(:user).should == @user
    end
    it "should have the right title" do
      get :show, :id=>@user
      response.should have_selector('title', :content=>@user.name)
    end
    it "should have the user's name" do
      get :show, :id=>@user
      response.should have_selector('h1', :content=>@user.name)
    end
    it "should have a profile image" do
      get :show, :id=>@user
      response.should have_selector('h1>img', :class=>"gravatar round")
    end
    it "should have the right URL" do
      get :show, :id=>@user
      response.should have_selector('td>a', :content=>user_path(@user), :href=>user_path(@user))
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content=>"Sign up")
    end
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr={:name=>"",:email=>"",:password=>"",:password_confirmation=>""}
      end
      it "should have the right title" do
        post :create, :user=>@attr
        response.should have_selector('title',:content=>"Sign up")
      end
      
      it "should render the new page" do
        post :create, :user=>@attr
        response.should render_template('new')
      end
      
      it "should not create a user" do
      lambda do
        post :create, :user=>@attr
      end.should_not change(User, :count)
    end
  end
  
    describe "success" do
      before(:each) do
        @attr={:name=>"New user", :email=>"user@example.com", :password=>"example", :password_confirmation=>"example"}
      end
      it "should create a user" do
        lambda do
          post :create, :user=>@attr
        end.should change(User, :count).by(1)
      end
      it "should redirect to the user show page" do
        post :create, :user=>@attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      it "should have a welcome message" do
        post :create, :user=>@attr
        flash[:success].should =~ /Welcome to the Example App./i
      end
      it "should sign the user in" do
        post :create, :user=>@attr
        controller.should be_signed_in
      end
    end
  end
  
  describe "GET 'edit" do
    before(:each) do
      @user=FactoryGirl.create(:user)
      test_sign_in(@user)
    end
    it "should be successful" do
      get :edit, :id=>@user
      response.should  be_success
    end
    it "should have the right title" do
      get :edit, :id=>@user
      response.should have_selector('title', :content=>"Edit user")
    end
    it "should have a link to change the gravatar" do
      get :edit, :id=>@user
      response.should have_selector("a",:href=>'http://gravatar.com/emails', :content=>"change your gravatar")
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @user=FactoryGirl.create(:user)
      test_sign_in(@user)
    end
    describe "failure" do
      before(:each) do
        @attr={:name=>"",:password=>"",:password_confirmation=>""}
      end
      it "should render 'edit' page" do
        put :update, :id=>@user, :user=>@attr
        response.should render_template('edit')
      end
      it "should have the right title" do
        put :update, :id=>@user, :user=>@attr
        response.should have_selector('title',:content=>"Edit user")
      end
      end
      describe "success" do
        before(:each) do
          @attr={:name=>"New name", :email=>"user@example.org",:password=>"barbaz",:password_confirmation=>"barbaz"}
        end
        it "should change the user's attributes" do
          put :update, :id=>@user, :user=>@attr
          user=assigns(:user)
          @user.reload
          @user.name.should==user.name
          @user.email.should==user.email
          @user.encrypted_password.should==user.encrypted_password
        end
        it "should have a flash message" do
          put :update, :id=>@user, :user=>@attr
          flash[:success].should =~ /updated/
        end
        
      end
    end
  
end



