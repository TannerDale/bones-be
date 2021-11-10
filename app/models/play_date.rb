class PlayDate < ApplicationRecord
  after_update :destroy_rejected

  belongs_to :creator_dog, class_name: 'Dog'
  belongs_to :invited_dog, class_name: 'Dog'

  validates :location_id, presence: true
  validates :date, presence: true
  validates :time, presence: true

  enum invite_status: %i[pending accepted rejected]

  def self.user_pending_invites(id)
    pending
      .joins(:invited_dog)
      .merge(Dog.user_dogs(id))
  end

  def self.for_user(id)
    users_created(id) + users_invited(id)
  end

  def self.users_created(id)
    joins(:creator_dog)
      .merge(Dog.user_dogs(id))
  end

  def self.users_invited(id)
    joins(:invited_dog)
      .merge(Dog.user_dogs(id))
  end

  def destroy_rejected
    destroy if invite_status == 'rejected'
  end
end
