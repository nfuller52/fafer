require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do
  describe "POST #create" do
    let(:platform) { create(:platform, item: create(:item)) }

    context "when the job list has not been published yet" do
      let(:job_listing) { create(:not_published_job_listing, platform: platform) }

      it "sets the expiration date" do
        post :create, params: { id: job_listing.to_param }

        job_listing.reload

        expect(job_listing.publish_date).to eq(Date.current)
        expect(job_listing.expiration_date).to eq(Date.current + JobListing::PUBLISH_DURATION_IN_DAYS.days)
      end

      it "redirects to the listing" do
        post :create, params: { id: job_listing.to_param }
        expect(response).to redirect_to(platform_path(job_listing.platform))
      end
    end

    context "when the job listing is already published" do
      let(:job_listing) { create(:job_listing, platform: platform) }

      it "returns a success response (i.e. to display the 'job_listings/edit' template)" do
        post :create, params: { id: job_listing.to_param }

        expect(response).to be_successful
        expect(response).to render_template("job_listings/edit")
      end
    end
  end
end
