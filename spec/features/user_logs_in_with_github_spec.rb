require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using rspec oauth" do
    user = create(:user)
    stub_omniauth
    stub_request(:get, "https://api.github.com/users/#{user.login}/starred").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'token accf1f94643378e4111744f29ea495b2fbf1eb4b',
          'User-Agent'=>'Faraday v0.12.2'
           }).to_return(status: 200, body: File.read('./spec/mock_requests/starred.json'), headers: {})


    visit root_path

    expect(page).to have_link("Login")
    click_link "Login"

    expect(page).to have_content("Welcome, Stephen")
    expect(page).to have_link("Logout")
  end
end
