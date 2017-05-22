FactoryGirl.define do
  factory :task do
    title { Faker::Lorem.word }
    status false
    user_id { create(:user).id }
  end
end
