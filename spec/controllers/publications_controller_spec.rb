require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do
  describe "POST #create" do
    let(:job_listing) { create(:not_published_job_listing) }

    context "when the job list can be published" do
      it "sets the expiration date" do
        post :create, params: { id: job_listing.to_param }

        job_listing.reload

        expect(job_listing.publish_date).to eq(Date.current)
        expect(job_listing.expiration_date).to eq(Date.current + JobListing::PUBLISH_DURATION_IN_DAYS.days)
      end

      it "redirects to the listing" do
        post :create, params: { id: job_listing.to_param }
        expect(response).to redirect_to(job_listings_path)
      end
    end

    context "when the job listing can not be published" do
      it "returns a success response (i.e. to display the 'job_listings/edit' template)" do
        allow(JobListing).to receive(:friendly).and_return(JobListing)
        allow(JobListing).to receive(:find).and_return(build(:not_published_job_listing, title: nil))

        post :create, params: { id: "whatever" }

        expect(response).to be_successful
        expect(response).to render_template("job_listings/edit")
      end
    end
  end
end
