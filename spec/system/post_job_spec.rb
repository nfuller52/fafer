require "rails_helper"

RSpec.describe "post a job" do
  let!(:platform) { create(:platform, item: create(:item)) }

  def complete_job_listings_form
    fill_in "job_listing_title", with: "Job Listing Name"
    select platform.name, from: "job_listing_platform_id"
    fill_in "job_listing_location", with: "Santa Rosa, CA"
    fill_in "job_listing_company", with: "Death Star Corp"
    fill_in "job_listing_description", with: "Job description text"
    fill_in "job_listing_contact_name", with: "Doc McStuffins"
    fill_in "job_listing_contact_email", with: "drmcstuffins@disney.com"
    click_button "Create Job listing"
  end

  def create_a_job_listing
    visit("/")
    click_link(href: new_job_listing_path)
    complete_job_listings_form
  end

  it "has a button to create a job on the homepage" do
    visit("/")
    expect(page).to have_link(href: new_job_listing_path)
  end

  it "selects the platform when a job is posted from a platform list page" do
    visit(platform_path(platform))
    expect(page).to have_link(href: new_job_listing_path(platform: platform.to_param))

    click_link(href: new_job_listing_path(platform: platform.to_param))
    expect(page).to have_select("job_listing_platform_id", selected: platform.name)
  end

  it "shows the listing in preview mode after submitting the new form" do
    create_a_job_listing

    expect(page).to have_content("Preview Mode")
    expect(page).to have_content("Job description text")
  end

  it "allows the user to edit the listing before paying" do
    create_a_job_listing

    click_link("Edit")
    fill_in "job_listing_description", with: "Completely random edit!"
    click_button("Update Job listing")

    expect(page).to have_content("Preview Mode")
    expect(page).to have_content("Completely random edit!")
  end

  it "prompts the user to pay for the job listing" do
    create_a_job_listing

    click_link "Complete Listing"
    expect(page).to have_selector("#order_customer_email[value='drmcstuffins@disney.com']")
  end

  it "allows the user to pay for services" do
    # create_a_job_listing
    # click_link "Complete Listing"
    #
    # within_frame "Secure payment input frame" do
    #   fill_in "cardnumber", with: "4242 4242 4242 4242"
    #   fill_in "exp-date", with: "04 / #{(Date.current.year + 2).to_s[2..4]}"
    #   fill_in "postal", with: "95403"
    # end
    #
    # click_button "Submit Payment"
    #
    # expect(page).to have_content("Payment Received")
  end
end
