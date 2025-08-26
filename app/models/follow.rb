class Follow < ApplicationRecord
  enum :status, pending: 0, accepted: 1, declined: 2

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :not_self

  private
  def not_self
    errors.add(:followed_id, "cannot be yourself") if follower_id == followed_id
  end
end