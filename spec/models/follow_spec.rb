require "rails_helper"

RSpec.describe Follow, type: :model do
  it "prevents self-follow" do
    u = User.create!(email: "x@y.com", password: "password123")
    f = Follow.new(follower: u, followed: u)
    expect(f).not_to be_valid
  end
end
