require 'rails_helper'

describe 'user visits /user/:id' do
  it 'sees a list of all followers of the user' do
    user = create(:user)

    stub_request(:get, "https://api.github.com/users/#{user.login}/followers").to_return(status: 200, body: File.read('./spec/mock_requests/followers.json'), headers: {})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit followers_path

    expect(current_path).to eq('/followers')
    expect(page).to have_css('.follower', count: 2)

    within(first('.follower')) do
      expect(page).to have_css('.follower-login')
      expect(page).to have_css('.follower-image')
    end
  end
end
