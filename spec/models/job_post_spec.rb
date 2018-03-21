require 'rails_helper'

RSpec.describe JobPost, type: :model do
  it "can be" do
    expect(described_class.new).to be_instance_of(described_class)
  end
end
