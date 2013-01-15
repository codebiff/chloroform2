require 'spec_helper'

describe ApiController do

  let(:user) { FactoryGirl.create(:user) }
  let(:params) { {name: "Joe Example", email: "joe@example.com", comment: "This is a short comment"} }

  it "should find a user api_key matches" do
    post :submit, params.merge({api_key: user.api_key})
    assigns(:user).should eq(user)
  end

  it "should submit a new message" do
    expect{ post :submit, params.merge({api_key: user.api_key}) }.to change(user.messages, :count).by(1)
  end

end
