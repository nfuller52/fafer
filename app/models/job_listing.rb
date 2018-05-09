class JobListing < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  PUBLISH_DURATION_IN_DAYS = 30

  enum status: %w(pending published expired)

  delegate :item, to: :platform, allow_nil: false

  belongs_to :platform
  has_one :order

  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :company, presence: true
  validates :contact_name, presence: true
  validates :contact_email, presence: true, "valid_email_2/email": { disposable: true, disallow_subaddressing: true }

  scope :published, -> do
    where("expiration_date >= ?", Date.current)
    .order(expiration_date: :desc, id: :desc)
    .includes(:platform)
  end

  def name
    [
      [:company, :title],
      [:company, :title, :location]
    ]
  end

  def publish!
    return false unless valid? && !published?
    update(publish_date: Date.current, expiration_date: Date.current + PUBLISH_DURATION_IN_DAYS.days)
  end

  def published?
    publish_date.present? && expiration_date.present?
  end

  def can_be_updated?
    valid? && !published?
  end

  def has_order?
    !order.nil?
  end

  def expire!

  end
end
