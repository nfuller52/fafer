class Platform < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  belongs_to :item

  validates :name, presence: true, uniqueness: true

  scope :active, -> { all }
end
