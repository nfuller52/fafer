FactoryBot.define do
  factory :order do
    total_in_cents { (10000..500_000).to_a.sample }
    customer_email { Faker::Internet.email }
    job_listing
  end
end
