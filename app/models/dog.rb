class Dog < ApplicationRecord
  validates_presence_of :name, :user_id
  has_many :created_play_dates, class_name: 'PlayDate', foreign_key: 'creator_dog_id'
  has_many :invited_play_dates, class_name: 'PlayDate', foreign_key: 'invited_dog_id'

  enum size: %w[small medium large]
  enum vaccinated: %w[false true]
  enum trained: %w[no yes]

  def self.find_user_dogs(id)
    where(user_id: id)
  end

  def self.exclude_user_dogs(id)
    where.not(user_id: id)
  end

  def play_dates
    created_play_dates + invited_play_dates
  end
end
