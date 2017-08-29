class Event < ApplicationRecord
  belongs_to :user
  has_many :rosters
  has_many :attendees, through: :rosters, source: :user
end
