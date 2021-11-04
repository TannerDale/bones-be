class Pet < ApplicationRecord
  validates_presence_of :name, :user_id

  enum size: %w[small medium large]
  enum vaccinated: %w[false true]
  enum trained: %w[no yes]

  def self.find_user_dogs(id)
    where(user_id: id)
  end

  def self.exclude_user_dogs(id)
    where.not(user_id: id)
  end
end
