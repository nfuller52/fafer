require 'rails_helper'

RSpec.describe Item do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price_in_cents) }
  end

  describe "scopes" do
    describe ".upsell_items" do
      let(:feature_item) { create(:item, feature_flag: "cheaper") }
      let(:non_feature_item) { create(:item, feature_flag: nil) }

      subject { described_class.upsell_items }

      it "includes items with the feature_flag value set" do
        expect(subject).to include(feature_item)
      end

      it "excludes items where the feature_flag value is not set" do
        expect(subject).not_to include(non_feature_item)
      end
    end
  end

  describe "#price" do
    let(:item) { build(:item, price_in_cents: 100_000) }

    subject { item.price }

    it "converts the price in cents to a fload" do
      expect(subject).to be_a(Float)
    end

    it "divides the price in cents by 100" do
      expect(subject).to eq(1000.00)
    end
  end
end
