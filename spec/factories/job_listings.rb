FactoryBot.define do
  factory :job_listing do
    title "Accounting Professional"
    allow_remote false
    location "San Francisco, CA"
    description "Job post with all sorts of stuff"
    slug "big-business-accounting-professional"
    company "Big Business"
    contact "test@example.com"
    publish_date { Date.current - 7.days }
    expiration_date { Date.current + 23.days }
    platform

    factory :not_published_job_listing do
      publish_date nil
      expiration_date nil
    end
  end

  factory :random_job_listing, class: JobListing do
    title { Faker::Job.title }
    allow_remote { [true, false].sample }
    location { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    description { Faker::Markdown.random }
    company { Faker::Company.name }
    contact_name { Faker::Name.name }
    contact_email { Faker::Internet.email }
    publish_date { (Date.current.last_month...Date.current).to_a.sample }
    expiration_date { (Date.current...Date.current + 1.month).to_a.sample }
    platform
  end
end
