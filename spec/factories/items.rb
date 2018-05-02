FactoryBot.define do
  factory :item do
    name "Job Listing Item"
    price_in_cents 500000
    feature_flag nil
  end

  factory :feature_item do
    name "Highlighted Feature Item"
    price_in_cents 27000
    feature_flag "is_highlighted"
  end

  factory :random_item do
    name { Faker::StarWars.droid }
    price_in_cents { (1000..9999).to_a.sample }
    feature_flag { [nil, Faker::Name.name.parameterize(separator: "_")].sample }
  end
end
