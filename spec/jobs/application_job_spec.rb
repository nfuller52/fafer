require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it "can be" do
    expect(described_class.new).to be_instance_of(described_class)
  end
end
