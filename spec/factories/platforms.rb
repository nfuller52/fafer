FactoryBot.define do
  factory :platform do
    name "NetSuite"
  end

  factory :random_platform, class: Platform do
    name { Faker::Name.name }
  end
end
