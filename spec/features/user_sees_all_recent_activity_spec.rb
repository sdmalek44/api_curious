require 'rails_helper'

describe 'user visits /recent_activity' do
  it 'can see a list of the last 10 commits made' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    stub_request(:get, "https://api.github.com/users/#{user.login}/events").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'token accf1f94643378e4111744f29ea495b2fbf1eb4b',
          'User-Agent'=>'Faraday v0.12.2'
           }).to_return(status: 200, body: File.read('./spec/mock_requests/events.json'))


    visit recent_activity_path

    expect(page).to have_content("#{user.name}'s Recent Commits")
    expect(page).to have_css(".commit", count: 10)

    within(first(".commit")) do
      expect(page).to have_css(".commit-author")
      expect(page).to have_css(".commit-repo-name")
      expect(page).to have_css(".commit-sha")
      expect(page).to have_css(".commit-message")
      expect(page).to have_css(".commit-created-at")
    end
  end
end
