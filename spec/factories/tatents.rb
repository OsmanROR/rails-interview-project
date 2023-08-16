FactoryBot.define do
  factory :tenant do
    name { Faker::Company.unique.name }

    after(:build) do |tenant|
      tenant.api_key = SecureRandom.hex(32)
    end
  end
end
