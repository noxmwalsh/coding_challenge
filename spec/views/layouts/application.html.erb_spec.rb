require 'rails_helper'

RSpec.describe "layouts/application", type: :view do
  let(:user) { create(:user) }

  before do
    without_partial_double_verification do
      allow(view).to receive(:user_signed_in?).and_return(false)
      allow(view).to receive(:current_user).and_return(nil)
    end
  end

  context "when user is signed in" do
    before do
      without_partial_double_verification do
        allow(view).to receive(:user_signed_in?).and_return(true)
        allow(view).to receive(:current_user).and_return(user)
      end
    end

    it "displays user email in the navigation" do
      render
      expect(rendered).to have_content(user.email)
    end

    it "shows sign out link" do
      render
      expect(rendered).to have_link("Sign Out", href: destroy_user_session_path)
    end
  end

  context "when user is not signed in" do
    it "shows sign in link" do
      render
      expect(rendered).to have_link("Sign In", href: new_user_session_path)
    end

    it "shows sign up link" do
      render
      expect(rendered).to have_link("Sign Up", href: new_user_registration_path)
    end
  end

  context "flash messages" do
    it "displays notice messages" do
      flash[:notice] = "Test notice"
      render
      expect(rendered).to have_content("Test notice")
    end

    it "displays alert messages" do
      flash[:alert] = "Test alert"
      render
      expect(rendered).to have_content("Test alert")
    end
  end

  it "includes the main container" do
    render
    expect(rendered).to have_css(".container")
  end
end
