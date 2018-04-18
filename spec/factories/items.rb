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
end
