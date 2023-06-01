class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :course
  belongs_to :user

  validates :title, presence: true, length: {minimum: 1}
  validates :body, presence: true, length: {minimum: 1}


end
