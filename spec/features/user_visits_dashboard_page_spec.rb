require 'rails_helper'

describe 'user visits /dashboard' do
  it 'sees a list of all followers of the user' do
    user = create(:user)
    stub_request(:get, "https://api.github.com/users/#{user.login}/starred").to_return(status: 200, body: File.read('./spec/mock_requests/starred.json'), headers: {})

    stub_request(:get, "https://api.github.com/users/#{user.login}/followers").to_return(status: 200, body: File.read('./spec/mock_requests/followers.json'), headers: {})

    stub_request(:get, "https://api.github.com/users/#{user.login}/following").to_return(status: 200, body: File.read('./spec/mock_requests/following.json'), headers: {})


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_css('.starred')

    within('.starred') do
      expect(page).to have_content('3')
    end
    within('.followers') do
      expect(page).to have_content('2')
    end
    within('.following') do
      expect(page).to have_content('1')
    end
  end
end
