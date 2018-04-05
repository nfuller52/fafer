require 'rails_helper'

RSpec.describe JobListing, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:publish_on) }
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:contact) }

    describe "publish_on" do
      it "should default to today" do
        expect(described_class.new.publish_on.to_date).to eq(DateTime.current.to_date)
      end
    end

    describe "platform" do
      it "should default to NetSuite" do
        expect(described_class.new.platform).to eq("net_suite")
      end
    end
  end

  describe "scopes" do
    describe "#published" do
      let(:job_listing) { create(:job_listing) }

      subject { described_class.published }

      context "when a job listing is published within the last month" do
        it "is included" do
          expect(subject).to include(job_listing)
        end
      end

      context "when a job listing is published more than a month ago" do
        let(:job_listing) { create(:expired_job_listing) }

        it "is not included" do
          expect(subject).not_to include(job_listing)
        end
      end

      context "when a job listing is published in the future" do
        let(:job_listing) { create(:future_job_listing) }

        it "is not included" do
          expect(subject).not_to include(job_listing)
        end
      end
    end
  end

  describe "#erp" do
    let(:job_listing) { described_class.new(platform: platform) }
    let(:platform) { "net_suite" }

    context "when platform is set" do
      describe "when platform is net_suite" do
        it "#erp is NetSuite" do
          job_listing.platform = "net_suite"
          expect(job_listing.erp).to eq("NetSuite")
        end
      end

      describe "when platform is sap" do
        it "#erp is SAP" do
          job_listing.platform = "sap"
          expect(job_listing.erp).to eq("SAP")
        end
      end

      describe "when platform is oracle" do
        it "#erp is Oracle" do
          job_listing.platform = "oracle"
          expect(job_listing.erp).to eq("Oracle")
        end
      end
    end

    context "when platform is not set" do
      let(:platform) { nil }

      it "#erp is nil" do
        expect(job_listing.erp).to be_nil
      end
    end
  end
end
