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

  end

end
