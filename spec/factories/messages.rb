# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user { User.first || FactoryGirl.create(:user) }
    confirm_url { Faker::Internet.url }
    label { l = ["Label One","Label Two","Label Three"].sample; {"name" => l, "slug" => Message.sluggerize(l)} }
    data { {"Name" => Faker::Name.name, "Email" => Faker::Internet.email, "Message" => Faker::Lorem.paragraph} }
  end
end
