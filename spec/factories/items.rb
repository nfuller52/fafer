FactoryBot.define do
  factory :item do
    name { Faker::StarWars.droid }
    price_in_cents { (1000..9999).to_a.sample }
    feature_flag nil
  end

  factory :feature_item, class: Item do
    name { Faker::StarWars.droid }
    price_in_cents { (1000..9999).to_a.sample }
    feature_flag "is_highlighted"
  end
end
