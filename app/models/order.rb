class Order < ApplicationRecord
  belongs_to :job_listing
  has_many :order_items, dependent: :destroy
end
