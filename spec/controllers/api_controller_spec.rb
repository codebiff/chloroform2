require 'spec_helper'

describe ApiController do

  before :each do
    request.env["HTTP_REFERER"] = "http://test.com"
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:params) { {name: "Joe Example", email: "joe@example.com", comment: "This is a short comment"} }

  it "should find a user api_key matches" do
    post :submit, params.merge({api_key: user.api_key})
    assigns(:user).should eq(user)
  end

  it "should submit a new message if api_key matches" do
    expect{ post :submit, params.merge({api_key: user.api_key}) }.to change(user.messages, :count).by(1)
  end

  it "should not find a user api_key matches" do
    post :submit, params.merge({api_key: "foobar"})
    assigns(:user).should be_false
  end

  it "should not submit a new message if api_key matches" do
    expect{ post :submit, params.merge({api_key: "foobar"}) }.to change(user.messages, :count).by(0)
  end

  it "should redirect to the correct referer"

end
