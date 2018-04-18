class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :item, presence: true
  validates :order, presence: true
  validates :price_in_cents, presence: true
end
