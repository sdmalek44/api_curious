require 'rails_helper'

describe 'user visits /user/:id' do
  it 'sees a list of all followers of the user' do
    user = create(:user)

    stub_request(:get, "https://api.github.com/users/#{user.login}/followers").
     with(
       headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>'token accf1f94643378e4111744f29ea495b2fbf1eb4b',
      'User-Agent'=>'Faraday v0.12.2'
       }).to_return(status: 200, body: File.read('./spec/mock_requests/followers.json'), headers: {})

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
