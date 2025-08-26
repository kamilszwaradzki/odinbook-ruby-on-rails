class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one  :profile, dependent: :destroy
  has_many :posts,   dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy

  # Follow system
  has_many :active_follows,  class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy

  has_many :following,-> { where(follows: { status: :accepted }) }, through: :active_follows,  source: :followed
  has_many :followers,-> { where(follows: { status: :accepted }) }, through: :passive_follows, source: :follower

  after_create :build_default_profile
  after_commit :send_welcome_email, on: :create

  def feed
    Post.where(user_id: [id] + following.pluck(:id)).includes(:user, :comments, :likes).order(created_at: :desc)
  end

  private
  def build_default_profile
    create_profile!(display_name: email.split("@").first)
  end

  def send_welcome_email
    WelcomeMailer.welcome_email(self).deliver_later
  end
end
