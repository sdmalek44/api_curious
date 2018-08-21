require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using rspec oauth" do
    stub_omniauth

    visit root_path
    expect(page).to have_link("Login")
    click_link "Login"

    expect(page).to have_content("Welcome, Stephen")
    expect(page).to have_link("Logout")
  end
end
