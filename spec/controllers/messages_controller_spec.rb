require 'spec_helper'

describe MessagesController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:user) }

context "index" do

  it "should ask for sign in if not logged in" do
    sign_out(user)  
    get :index
    response.should redirect_to(new_user_session_path)
  end

  it "should find index if logged in" do
    user.confirm!
    sign_in(user)
    get :index
    response.should be_ok
  end

end

context "label" do

  it "should find all messages with a specific label" do
    user.confirm!
    20.times { FactoryGirl.create(:message) }
    sign_in(user)
    get :label, {:slug => 'label-one'}
    assigns(:messages).should_not be_empty
  end

end

end
