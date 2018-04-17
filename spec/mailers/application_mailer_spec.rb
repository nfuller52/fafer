require "rails_helper"

RSpec.describe ApplicationMailer, type: :mailer do
  it "can be" do
    expect(described_class.new).to be_instance_of(described_class)
  end
end
