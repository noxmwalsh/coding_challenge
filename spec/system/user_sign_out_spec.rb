require "rails_helper"

RSpec.describe "User sign out", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
    Warden.test_mode!
  end

  after do
    Warden.test_reset!
  end

  it "signs out successfully" do
    # Sign in the user
    login_as(user, scope: :user)
    visit root_path

    # Verify user is signed in
    expect(page).to have_content(user.email)
    expect(page).to have_link("Sign Out")

    # Click sign out link
    click_link "Sign Out"

    # Verify user is signed out
    expect(page).to have_content("Signed out successfully")
    expect(page).to have_link("Sign In")
    expect(page).to have_link("Sign Up")
    expect(page).not_to have_content(user.email)
  end

  it "redirects to root path after sign out" do
    # Sign in the user
    login_as(user, scope: :user)
    visit posts_path

    # Click sign out link
    click_link "Sign Out"

    # Verify redirect to root path
    expect(current_path).to eq(root_path)
  end

  it "cannot access protected pages after sign out" do
    # Sign in the user
    login_as(user, scope: :user)
    visit root_path

    # Sign out
    click_link "Sign Out"

    # Try to access a protected page
    visit new_post_path

    # Verify redirect to sign in page
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
