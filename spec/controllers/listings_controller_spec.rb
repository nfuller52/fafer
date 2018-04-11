require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #net_suite" do
    it "returns a success response" do
      get :net_suite, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #sap" do
    it "returns a success response" do
      get :sap, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #oracle" do
    it "returns a success response" do
      get :oracle, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    context "when the listing exists" do
      it "returns a success response" do
        job_listing = create(:job_listing)
        get :show, params: { id: job_listing.to_param }

        expect(response).to be_successful
      end
    end

    context "when the listing does not exist" do
      it "returns a 404" do
        expect { get :show, params: { id: "invalid-id" } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
