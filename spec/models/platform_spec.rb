require 'rails_helper'

RSpec.describe Platform, type: :model do
  let(:item) { build(:item) }

  describe "validations" do
    it { should validate_presence_of(:name) }

    it "validates the uniqueness of :name" do
      create(:platform, name: "System X", item: item)
      should validate_uniqueness_of(:name)
    end
  end
end
