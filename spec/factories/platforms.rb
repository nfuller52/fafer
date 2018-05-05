FactoryBot.define do
  factory :platform do
    name { Faker::StarWars.call_sign }
  end
end
