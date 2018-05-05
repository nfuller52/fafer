require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:platform_item) { create(:item) }
  let(:platform) { create(:platform, item: platform_item) }
  let(:job_listing) { create(:job_listing, platform: platform) }
  let(:order) { create(:order, job_listing: job_listing) }

  describe "validations" do
    it "has a valid factory" do
      expect(order).to be_valid
    end

    it { should validate_presence_of(:customer_email) }
  end

  describe "#sub_total" do
    context "when order items are present" do
      let(:sold_item) { create(:item) }
      let!(:order_items) { create_list(:order_item, 4, order: order, item: sold_item) }

      it "totals the price from each order item" do
        expect(order.sub_total).to eq(order_items.map(&:price_in_cents).sum)
      end
    end

    context "when no order items are present" do
      it "is 0" do
        expect(order.sub_total).to eq(0)
      end
    end
  end

  describe "#calculate_total" do
    context "when order items are present" do
      let(:sold_item) { create(:item) }
      let!(:order_items) { create_list(:order_item, 4, order: order, item: sold_item) }

      it "sets the order total in cents to the sum of all item price in cents" do
        order.calculate_total

        expect(order.total_in_cents).to eq(order_items.map(&:price_in_cents).sum)
      end
    end

    context "when order items are not present" do
      it "sets the order total in cents to 0" do
        order.calculate_total

        expect(order.total_in_cents).to eq(0)
      end
    end
  end
end
