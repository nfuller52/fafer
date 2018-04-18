unless Rails.env.production?
  require 'seed'

  title = "SEEDING #{Rails.env.upcase}"
  line_length = 79
  padding = (line_length - 8 - title.length) / 2
  printf(("#" * line_length) + "\n")
  printf("####" + (" " * padding) + "%s" + (" " * padding) + "####\n", title)
  printf(("#" * line_length) + "\n\n")

  # Items
  ######################################################
  Seed.start("Item") do
    Seed.step("destroy_all(:items)") { Item.destroy_all }

    items = [
      { name: "NetSuite Job Listing", price_in_cents: 501000, feature_flag: nil },
      { name: "Oracle Job Listing", price_in_cents: 501000, feature_flag: nil },
      { name: "SAP Job Listing", price_in_cents: 501000, feature_flag: nil },
      { name: "Highlight Listing", price_in_cents: 27000, feature_flag: "is_highlighted" },
      { name: "Keep At Top of the List for 5 Days", price_in_cents: 27000, feature_flag: "is_prominent" }
    ]
    Seed.step("create(:items) #{items.length} records") do
      items.each { |attributes| Item.create(attributes) }
    end
  end

  # Platforms
  ######################################################
  Seed.start("Platform") do
    Seed.step("destroy_all(:platforms)") { Platform.destroy_all }

    platform_names = ["NetSuite", "Oracle", "SAP"]
    Seed.step("create(:platforms) #{platform_names.length} records") do
      platform_names.each_with_index do |platform_name, index|
        Platform.where(name: platform_name, item_id: index + 1).first_or_create
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

  job_listings = JobListing.all

  # Order
  ######################################################
  Seed.start("Order") do
    Seed.step("destroy_all(:orders)") { Order.destroy_all }

    Seed.step("create(:order) #{job_listings.count} records") do
      job_listings.each do |job_listing|
        item = job_listing.item
        upgrade_count = (0..2).to_a.sample

        built_order_items = [OrderItem.create(item_id: item.id, price_in_cents: item.price_in_cents)]
        upgrade_count.times do |i|
          item = Item.upgrades[i]
          built_order_items << OrderItem.create(item_id: item.id, price_in_cents: item.price_in_cents)
        end

        order = Order.where(job_listing_id: job_listing.id).first_or_create do |order|
          status = Order.statuses.keys
          customer_email = Faker::Internet.email
        end

        order.order_items = built_order_items
        order.update(total_in_cents: order.sub_total)
      end
    end
  end
end
