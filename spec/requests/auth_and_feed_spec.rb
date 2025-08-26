require "rails_helper"

RSpec.feature "AuthWall", type: :feature do
  scenario "redirects to sign in when visiting root" do
    visit "/"
    expect(page).to have_content("Log in")
  end

  scenario "user signs in and sees feed" do
    user = User.create!(email: "user@example.com", password: "password123")
    visit "/users/sign_in"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password123"
    click_button "Log in"
    expect(page).to have_content("Feed")
  end
end
