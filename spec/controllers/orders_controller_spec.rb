require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  let(:platform) { create(:platform, item: create(:item)) }
  let(:job_listing) { create(:job_listing, platform: platform) }

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { job_listing: job_listing.to_param }
      expect(response).to be_successful
    end
  end

  describe "#POST #create" do
  end
end
