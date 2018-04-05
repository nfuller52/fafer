FactoryBot.define do
  factory :job_listing do
    title "Accounting Professional"
    platform "net_suite"
    allow_remote false
    location "San Francisco, CA"
    description "Job post with all sorts of stuff"
    slug "big-business-accounting-professional"
    company "Big Business"
    contact "test@example.com"
    publish_on { DateTime.current - 1.day }

    factory :expired_job_listing do
      publish_on { DateTime.current - 2.months }
    end

    factory :future_job_listing do
      publish_on { DateTime.current + 2.months }
    end
  end

  factory :random_job_listing, class: JobListing do
    title { Faker::Job.title }
    platform { JobListing.platforms.keys.sample }
    allow_remote { [true, false].sample }
    location { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    description { Faker::Markdown.random }
    company { Faker::Company.name }
    contact { Faker::Internet.email }
    publish_on { (DateTime.current.last_month...DateTime.current).to_a.sample }
  end
end
