class Order < ApplicationRecord
  belongs_to :job_listing
  has_many :order_items, dependent: :destroy

  before_save :calculate_total

  enum status: %w(pending paid declined)

  validates :job_listing, presence: true
  validates :customer_email, presence: true, "valid_email_2/email": { disposable: true, disallow_subaddressing: true }

  def sub_total
    order_items.pluck(:price_in_cents).inject(0, :+)
  end

  def calculate_total
    self.total_in_cents = order_items.map(&:price_in_cents).inject(0, :+)
  end
end
