class PlayDate < ApplicationRecord
  belongs_to :creator_dog, class_name: 'Dog'
  belongs_to :invited_dog, class_name: 'Dog'
end
