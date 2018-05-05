require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:job_listing) { build(:job_listing) }
  let(:order) { build(:order, job_listing: job_listing) }

  describe "validations" do
    it "has a valid factory" do
      expect(order).to be_valid
    end
  end
end
