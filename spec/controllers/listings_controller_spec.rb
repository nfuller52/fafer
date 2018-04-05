require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    context "when the listing exists" do
      it "returns a success response" do
        allow(JobListing).to receive(:friendly).and_return([build(:job_listing)])

        get :show, params: { id: "valid-id" }
        expect(response).to be_success
      end
    end

    context "when the listing does not exist" do
      it "returns a 404" do
        expect { get :show, params: { id: "invalid-id" } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
