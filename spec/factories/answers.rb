FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.paragraph }
    association :question
    association :user
  end
end
