class Pet < ApplicationRecord
  validates_presence_of :name, :user_id

  enum size: %w[small medium large]
end
