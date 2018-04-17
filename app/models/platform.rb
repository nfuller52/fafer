class Platform < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  validates :name, presence: true, uniqueness: true
end
