class JobListing < ApplicationRecord
  extend FriendlyId
  friendly_id :company_listing, use: :slugged

  PLATFORM_TITLES = { net_suite: "NetSuite", oracle: "Oracle", sap: "SAP" }

  before_create :set_publish_on

  enum platform: { net_suite: 0, oracle: 1, sap: 2 }

  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :publish_on, presence: true
  validates :company, presence: true
  validates :contact, presence: true

  scope :published, -> do
    where(publish_on: DateTime.current.beginning_of_day - 1.month..DateTime.current.end_of_day)
  end

  def erp
    PLATFORM_TITLES[platform.try(:to_sym)]
  end

  def set_publish_on
    publish_on = DateTime.current if publish_on.present?
  end

  private

  def company_listing
    [company, title].join(' ')
  end
end
