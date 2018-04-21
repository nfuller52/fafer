class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price_in_cents, presence: true

  scope :upsell_items, -> { where.not(feature_flag: nil) }

  def price
    price_in_cents / 100.0
  end
end
