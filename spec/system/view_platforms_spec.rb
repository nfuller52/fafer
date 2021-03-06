require "rails_helper"

RSpec.describe "platforms" do
  it "show page displays the name of the platform" do
    item = create(:item)
    platform = create(:platform, item: item)

    visit("/platforms/#{platform.slug}")
    expect(page).to have_content("#{platform.name} Listings")
  end
end
