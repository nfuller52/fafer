class JobListing < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  PUBLISH_DURATION_IN_DAYS = 30

  belongs_to :platform

  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :company, presence: true
  validates :contact, presence: true
  validates :platform, presence: true

  scope :published, -> do
    where("expiration_date >= ?", Date.current).order(expiration_date: :desc, id: :desc)
  end

  def name
    return false unless company.present? && title.present?
    [company, title].join(' - ')
  end

  def publish!
    return false unless valid?
    update(publish_date: Date.current, expiration_date: Date.current + PUBLISH_DURATION_IN_DAYS.days)
  end

  def published?
    publish_date.present? && expiration_date.present?
  end
end
