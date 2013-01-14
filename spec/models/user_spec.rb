require 'spec_helper'

describe User do
  
  let(:user) { FactoryGirl.create(:user) }

  context "api_Key" do
    it "should be present" do
      expect(user).to respond_to(:api_key)
      user.api_key.should_not be_nil
    end
  end

end
