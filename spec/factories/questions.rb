FactoryBot.define do
  factory :question do
    title { Faker::Lorem.unique.sentence }
    association :user

    after(:create) do |question|
      create_list(:answer, 5, question: question)
    end
  end
end
