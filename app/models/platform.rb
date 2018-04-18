class Platform < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  belongs_to :item

  validates :name, presence: true, uniqueness: true
  validates :item, presence: true

  scope :active, -> { all }
end
