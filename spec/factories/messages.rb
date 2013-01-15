# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message, :class => 'Messages' do
    user_id nil
    data ""
  end
end
