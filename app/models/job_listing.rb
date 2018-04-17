class JobListing < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  PLATFORM_TITLES = { net_suite: "NetSuite", oracle: "Oracle", sap: "SAP" }
  PUBLISH_DURATION_IN_DAYS = 30

  enum platform: { net_suite: 0, oracle: 1, sap: 2 }

  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :company, presence: true
  validates :contact, presence: true
  validates :platform, presence: true

  scope :published, -> { where("expiration_date >= ?", Date.current) }

  def self.valid_platform?(platform)
    JobListing.platforms.keys.include?(platform.to_s)
  end

  def self.default_platform
    JobListing.platforms.keys.first
  end

  def erp
    PLATFORM_TITLES[platform.try(:to_sym)]
  end

  def publish!
    return false unless valid?
    update(publish_date: Date.current, expiration_date: Date.current + PUBLISH_DURATION_IN_DAYS.days)
  end

  def published?
    publish_date.present? && expiration_date.present?
  end

  def name
    return false unless company.present? && title.present?
    [company, title].join(' - ')
  end
end
