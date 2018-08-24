require 'rails_helper'

describe 'visit /organizations' do
  it 'can see all users organizations' do
    user = create(:user)

    stub_request(:get, "https://api.github.com/users/#{user.login}/followers").to_return(status: 200, body: File.read('./spec/mock_requests/followers.json'))
    stub_request(:get, "https://api.github.com/users/#{user.login}/following").to_return(status: 200, body: File.read('./spec/mock_requests/following.json'))
    stub_request(:get, "https://api.github.com/users/#{user.login}/starred").to_return(status: 200, body: File.read('./spec/mock_requests/starred.json'))
    stub_request(:get, "https://api.github.com/users/#{user.login}/orgs").to_return(status: 200, body: File.read('./spec/mock_requests/orgs.json'))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on "Organizations"

    expect(current_path).to eq(organizations_path)

    within(first(".organization")) do
      expect(page).to have_css(".org-login")
      expect(page).to have_css(".org-url")
      expect(page).to have_css(".org-description")
    end
  end
end
