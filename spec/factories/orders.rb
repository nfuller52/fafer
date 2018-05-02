FactoryBot.define do
  factory :order do
    total_in_cents 500_000
    customer_email "test@example.com"
    association :job_listing, factory: :random_job_listing
  end
end
