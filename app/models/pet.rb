class Pet < ApplicationRecord
  validates_presence_of :name, :user_id

  enum size: %w[small medium large]
  enum vaccinated: %w[false true]
  enum trained: %w[no yes]
end
