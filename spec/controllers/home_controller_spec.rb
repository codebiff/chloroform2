require 'spec_helper'

describe HomeController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do

    it "should not redirect if not logged in" do
      get :index
      response.sould_not be_redirect
    end

    it "should redirect to dashboard if logged in" do
      user.confirm!
      sign_in(user)
      get :index
      response.should be_redirect
    end

  end

end
