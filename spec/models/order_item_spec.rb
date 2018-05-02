require 'rails_helper'

RSpec.describe OrderItem do
  describe "validations" do
    it "has a valid factory" do
      expect(build(:order_item)).to be_valid
    end
  end
end
