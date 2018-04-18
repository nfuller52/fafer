class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price_in_cents, presence: true

  scope :upgrades, -> { where.not(feature_flag: nil) }
end
