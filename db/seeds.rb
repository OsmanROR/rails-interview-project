require 'faker'

10.times do |i|
  Tenant.create!(name: Faker::Company.name)
end

10.times do
  User.create!(name: Faker::Name.name)
end

20.times do
  question = Question.create!(title: Faker::Lorem.sentence, private: [true, false].sample, user: User.all.sample)
  5.times do
    Answer.create!(body: Faker::Lorem.paragraph, question: question, user: User.all.sample)
  end
end