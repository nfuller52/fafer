require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
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
end
