require 'rails_helper'

RSpec.describe JobListingsController, type: :controller do
  let(:valid_attributes) { attributes_for(:job_listing) }
  let(:invalid_attributes) { { title: nil, company: "", description: nil } }

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    context "when the job listing exists" do
      it "returns a success response" do
        allow(JobListing).to receive(:friendly).and_return([build(:job_listing)])

        get :edit, params: { id: "valid-id" }
        expect(response).to be_success
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
      before { allow_any_instance_of(JobListing).to receive(:save).and_return(true) }

      it "creates a new Listing" do
        post :create, params: { job_listing: valid_attributes }

        expect(flash[:notice]).to be_present
      end

      it "redirects to the created listing" do
        post :create, params: { job_listing: valid_attributes }

        expect(response).to have_http_status(:redirect)
        expect(response.status).to be(302)
        expect(response).to redirect_to("/" + response.request.parameters["job_listing"]["slug"])
      end
    end

    context "with invalid params" do
      before { allow_any_instance_of(JobListing).to receive(:save).and_return(false) }

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { job_listing: invalid_attributes }
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      before do
        allow(JobListing).to receive(:friendly).and_return(ActiveRecord::Relation.new)
        allow(ActiveRecord::Relation).to receive(:find).and_return(build(:job_listing))
        allow_any_instance_of(JobListing).to receive(:save).and_return(true)
      end

      it "updates the requested listing" do
        put :update, params: { id: "valid-id", job_listing: valid_attributes }

        expect(flash[:notice]).to be_present
      end

      it "redirects to the listing" do
        listing = JobListing.create! valid_attributes
        put :update, params: {id: listing.to_param, listing: valid_attributes}
        expect(response).to redirect_to(listing)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        listing = JobListing.create! valid_attributes
        put :update, params: {id: listing.to_param, listing: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested listing" do
      listing = JobListing.create! valid_attributes
      expect {
        delete :destroy, params: {id: listing.to_param}
      }.to change(JobListing, :count).by(-1)
    end

    it "redirects to the listings list" do
      listing = JobListing.create! valid_attributes
      delete :destroy, params: {id: listing.to_param}
      expect(response).to redirect_to(listings_url)
    end
  end
end
