require 'rails_helper'

RSpec.describe JobListingsController, type: :controller do
  let(:valid_attributes) { attributes_for(:job_listing) }
  let(:invalid_attributes) { attributes_for(:job_listing, title: nil) }

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}

      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    context "when the job listing exists" do
      it "returns a success response" do
        job_listing = JobListing.create!(valid_attributes)

        get :edit, params: { id: job_listing.slug }
        expect(response).to be_successful
      end
    end

    context "when the job listing does not exist" do
      it "returns a 404" do
        expect { get :edit, params: { id: "invalid-id" } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Listing" do
        expect {
          post :create, params: { job_listing: valid_attributes }
        }.to change(JobListing, :count).by(1)
      end

      it "redirects to the created job listing in preview mode" do
        post :create, params: { job_listing: valid_attributes }

        expect(response).to redirect_to(listing_path(JobListing.last, preview: true))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { job_listing: invalid_attributes }

        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { attributes_for(:random_job_listing) }

      it "updates the requested listing" do
        job_listing = JobListing.create!(valid_attributes)
        put :update, params: { id: job_listing.to_param, job_listing: new_attributes }
        job_listing.reload

        expect(job_listing.title).to eq(new_attributes[:title])
        expect(job_listing.platform).to eq(new_attributes[:platform])
        expect(job_listing.allow_remote).to eq(new_attributes[:allow_remote])
        expect(job_listing.location).to eq(new_attributes[:location])
        expect(job_listing.description).to eq(new_attributes[:description])
        expect(job_listing.company).to eq(new_attributes[:company])
        expect(job_listing.contact).to eq(new_attributes[:contact])
      end

      it "redirects to the listing" do
        job_listing = JobListing.create!(valid_attributes)
        put :update, params: { id: job_listing.to_param, job_listing: valid_attributes }

        expect(response).to redirect_to(listing_path(job_listing))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        job_listing = JobListing.create!(valid_attributes)
        put :update, params: { id: job_listing.to_param, job_listing: invalid_attributes }

        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested listing" do
      job_listing = JobListing.create!(valid_attributes)

      expect {
        delete :destroy, params: { id: job_listing.to_param }
      }.to change(JobListing, :count).by(-1)
    end

    it "redirects to the listings list" do
      job_listing = JobListing.create!(valid_attributes)
      delete :destroy, params: { id: job_listing.to_param }

      expect(response).to redirect_to(listings_url)
    end
  end
end
