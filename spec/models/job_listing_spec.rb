require 'rails_helper'

RSpec.describe JobListing, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:contact) }
    it { should validate_presence_of(:platform) }
  end

  describe "scopes" do
    describe "#published" do
      let(:job_listing) { create(:job_listing) }

      subject { described_class.published }

      context "when a job listing is published" do
        it "is included" do
          expect(subject).to include(job_listing)
        end
      end

      context "when a job listing is not published" do
        let(:job_listing) { create(:not_published_job_listing) }

        it "is not included" do
          expect(subject).not_to include(job_listing)
        end
      end
    end
  end

  describe "#publish!" do
    context "when the record is valid" do
      let(:job_listing) { create(:job_listing, publish_date: nil, expiration_date: nil) }

      before do
        job_listing.publish!
        job_listing.reload
      end

      it "sets a publish date to the current date" do
        expect(job_listing.publish_date).to eq(Date.current)
      end

      it "sets the expiration date to 30 days from now" do
        expect(job_listing.expiration_date).to eq(Date.current + 30.days)
      end
    end

    context "when the record is not valid" do
      let(:job_listing) { build(:job_listing, title: nil, publish_date: nil, expiration_date: nil) }

      before { job_listing.publish! }

      it "does not update the publish date" do
        expect(job_listing.publish_date).to be_nil
      end

      it "does not update the expiration date" do
        expect(job_listing.expiration_date).to be_nil
      end
    end
  end

  describe "#name" do
    let(:company) { "Fafer" }
    let(:title) { "Director of Keeping it Real" }
    let(:job_listing) { build(:job_listing, company: company, title: title) }

    subject { job_listing.name }

    context "invalid" do
      describe "when the company name is not set" do
        let(:company) { nil }

        it "is false" do
          expect(subject).to be_falsey
        end
      end

      describe "when the company name is blank" do
        let(:company) { "" }

        it "is false" do
          expect(subject).to be_falsey
        end
      end

      describe "when the title is not set" do
        let(:title) { nil }

        it "is false" do
          expect(subject).to be_falsey
        end
      end

      describe "when the title name is blank" do
        let(:title) { "" }

        it "is false" do
          expect(subject).to be_falsey
        end
      end
    end

    context "valid" do
      it "joins the company name and title with a hyphen" do
        expect(subject).to eq("#{company} - #{title}")
      end
    end
  end
end
