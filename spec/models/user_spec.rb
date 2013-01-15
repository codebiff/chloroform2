require 'spec_helper'

describe User do
  
  let(:user) { FactoryGirl.create(:user) }

  it { should respond_to(:settings) }
  it { user.settings.should be_kind_of(Hash) }

  it { user.api_key.should match(/^\w{32}$/) }

end
