require "rails_helper"

RSpec.describe User, type: :model do
  it "builds a profile on create and sends welcome email" do
    expect { @user = User.create!(email: "a@b.com", password: "password123") }
      .to change(Profile, :count).by(1)
  end

  it "returns feed containing own posts" do
    u = User.create!(email: "c@d.com", password: "password123")
    post = u.posts.create!(body: "hello")
    expect(u.feed).to include(post)
  end
end
