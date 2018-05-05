require "rails_helper"

RSpec.describe PlatformsController, type: :controller do
  describe "GET #show" do
    it "returns http success" do
      platform = create(:platform, item: build(:item))
      get :show, params: { id: platform.to_param }

      expect(response).to be_successful
    end
  end
end
