class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy

  validates :body, presence: true

  has_many :likers, through: :likes, source: :user
end