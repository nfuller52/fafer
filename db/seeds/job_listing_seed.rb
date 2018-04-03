require 'seed'

Seed.start("JobListing") do
  Seed.step("destroy_all(:job_listings)") { JobListing.destroy_all }

  records_to_create = 100
  Seed.step("create(:job_listings) #{records_to_create} records") do
    records_to_create.times do
      JobListing.where(company: Faker::Company.name, title: Faker::Job.title).first_or_create do |job_listing|
        job_listing.platform = JobListing.platforms.keys.sample
        job_listing.allow_remote = [true, false].sample
        job_listing.location = "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
        job_listing.description = Faker::Markdown.random
        job_listing.contact = Faker::Internet.email
        job_listing.publish_at = (DateTime.current.last_month...Date.current + 1.month).to_a.sample
      end
    end
  end
end
