class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :price_in_cents, presence: true
end
