class PlayDate < ApplicationRecord
  belongs_to :creator_dog, class_name: 'Dog'
  belongs_to :invited_dog, class_name: 'Dog'

  validates :location_id, presence: true
  validates :date, presence: true
  validates :time, presence: true
end
