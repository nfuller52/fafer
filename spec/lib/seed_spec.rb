require "rails_helper"
require "seed"

RSpec.describe Seed do
  it "can be" do
    expect(described_class.new).to be_instance_of(described_class)
  end
end
