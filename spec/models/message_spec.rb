require 'spec_helper'

describe Message do

  let(:user) { FactoryGirl.create(:user) }
  let(:params) { {name: "Joe Example", email: "joe@example.com", comment: "This is a short comment"} }

  it { should respond_to(:data) }

  it "should add params to the models data" do
    m = Message.generate(user, params)
    m.data.should have_key("name")
    m.data["name"].should eq("Joe Example")
  end

  it "should convert an array to comma seperated" do
    m = Message.generate(user, params.merge({list: ["one", "two", "three"]}))
    m.data["list"].should eq("one, two, three")
  end

  it "should not add the api_key to data" do
    m = Message.generate(user, params.merge({api_key: "123456"}))
    m.data.should_not have_key("api_key")
  end

  it "should not add the controller to data" do
    m = Message.generate(user, params.merge({controller: "123456"}))
    m.data.should_not have_key("controller")
  end

  it "should not add the action to data" do
    m = Message.generate(user, params.merge({action: "123456"}))
    m.data.should_not have_key("action")
  end

  it "should not add any params starting with an underscore to data" do
    m = Message.generate(user, params.merge({_foo: "bar"}))
    m.data.should_not have_key("_foo")
  end

  it "should not add confirm_url to data" do
    m = Message.generate(user, params.merge({confirm_url: "http://example.com"}))
    m.data.should_not have_key("confirm_url")
  end

  it "should set the confirm_url to the params value" do
    m = Message.generate(user, params.merge({confirm_url: "http://example.com"}))
    m.confirm_url.should eq("http://example.com")
  end

  it "should set the confirm_url to the referer value if params missing" do
    m = Message.generate(user, params, "http://referer-example.com")
    m.confirm_url.should eq("http://referer-example.com")
  end

  it "should set the confirm_url to the settings value if params missing" do
    user.settings[:confirm_url] = "http://settings-example.com"
    m = Message.generate(user, params, "http://referer-example.com")
    m.confirm_url.should eq("http://settings-example.com")
  end

  it "should set the confirm_url to the params value if also in settings" do
    user.settings[:confirm_url] = "http://settings-example.com"
    m = Message.generate(user, params.merge({confirm_url: "http://example.com"}), "http://referer-example.com")
    m.confirm_url.should eq("http://example.com")
  end

  it "should not create a message if no data is present" do
    expect{ Message.generate(user, {}) }.to_not change(Message, :count)
  end

end
