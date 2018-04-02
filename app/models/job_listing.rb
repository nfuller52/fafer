class JobListing < ApplicationRecord
  PLATFORM_TITLES = { net_suite: "NetSuite", oracle: "Oracle", sap: "SAP" }

  enum platform: { net_suite: 0, oracle: 1, sap: 2 }

  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :publish_at, presence: true
  validates :company, presence: true
  validates :contact, presence: true

  def erp
    PLATFORM_TITLES[platform.try(:to_sym)]
  end
end
