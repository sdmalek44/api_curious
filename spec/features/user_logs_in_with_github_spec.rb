require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using rspec oauth" do
    user = create(:user)
    stub_omniauth
    stub_request(:get, "https://api.github.com/users/#{user.login}/starred").to_return(status: 200, body: File.read('./spec/mock_requests/starred.json'), headers: {})

    stub_request(:get, "https://api.github.com/users/#{user.login}/followers").to_return(status: 200, body: File.read('./spec/mock_requests/followers.json'), headers: {})

    stub_request(:get, "https://api.github.com/users/#{user.login}/following").to_return(status: 200, body: File.read('./spec/mock_requests/following.json'), headers: {})

    visit root_path

    expect(page).to have_link("Login")
    click_link "Login"

    expect(page).to have_content("Welcome, Stephen")
    expect(page).to have_link("Logout")
  end
end
