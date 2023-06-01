class Task < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :title, presence: true, length: {minimum: 1}
  validates :body, presence: true, length: {minimum: 10}
  validates :deadline, presence: true, length: {minimum: 8}

end
