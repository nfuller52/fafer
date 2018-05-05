require 'rails_helper'

RSpec.describe OrderItem do
  let(:order) { build(:order) }
  let(:item) { build(:item) }
  let(:order_item) { build(:order_item, item: item, order: order) }

  describe "validations" do
    it "has a valid factory" do
      expect(order_item).to be_valid
    end
  end
end
