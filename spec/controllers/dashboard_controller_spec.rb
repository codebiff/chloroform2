require 'spec_helper'

describe DashboardController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do
    
    it "should redirecct to index if not logged in" do
      sign_out(user)  
      get :index
      response.should be_redirect
    end

    it "should find index if logged in" do
      user.confirm!
      sign_in(user)
      get :index
      response.should be_ok
    end

    it "should set the messages variable if empty" do
      user.confirm!
      sign_in(user)
      get :index
      assigns(:messages).should be_empty
    end

    it "should set the messages variable if messages exist" do
      user.confirm!
      5.times { FactoryGirl.create(:message) }
      sign_in(user)
      get :index
      assigns(:messages).should eq(user.messages)
    end

    it "should generate a list of form labels" do
      user.confirm!
      10.times { FactoryGirl.create(:message) }
      sign_in(user)
      get :index
      labels = user.messages.all.map{|m| {m.label["name"] => m.label["slug"]} }.uniq
      assigns(:labels).should eq(labels)
    end 

  end

end
