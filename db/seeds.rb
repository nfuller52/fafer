unless Rails.env.production?
  require 'seed'

  title = "SEEDING #{Rails.env.upcase}"
  line_length = 79
  padding = (line_length - 8 - title.length) / 2
  printf(("#" * line_length) + "\n")
  printf("####" + (" " * padding) + "%s" + (" " * padding) + "####\n", title)
  printf(("#" * line_length) + "\n\n")

  # Platforms
  ######################################################
  Seed.start("Platform") do
    Seed.step("destroy_all(:platforms)") { Platform.destroy_all }

    platform_names = ["Net Suite", "Oracle", "SAP"]
    Seed.step("create(:platforms) #{platform_names.length} records") do
      platform_names.each do |platform_name|
        Platform.find_or_create_by(name: platform_name)
      end
    end
  end

  platforms = Platform.all

  # JobListing
  ######################################################
  Seed.start("JobListing") do
    Seed.step("destroy_all(:job_listings)") { JobListing.destroy_all }

    records_to_create = 100
    Seed.step("create(:job_listings) #{records_to_create} records") do
      records_to_create.times do
        JobListing.where(company: Faker::Company.name, title: Faker::Job.title).first_or_create do |job_listing|
          job_listing.platform = platforms.sample
          job_listing.allow_remote = [true, false].sample
          job_listing.location = "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
          job_listing.description = Faker::Markdown.random
          job_listing.contact = Faker::Internet.email
          job_listing.publish_date = (DateTime.current.last_month...DateTime.current).to_a.sample
          job_listing.expiration_date = job_listing.publish_date + 30.days
        end
      end
    end
  end
end
