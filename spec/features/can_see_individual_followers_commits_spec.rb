require 'rails_helper'

describe 'user visits /recent_activity' do
  it 'can see a list of the last 10 commits made' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    date = 3.days.ago.strftime("%Y-%m-%d")
    login = user.login

    stub_request(:get, "https://api.github.com/users/#{login}/following").to_return(status: 200, body: File.read('./spec/mock_requests/followers.json'), headers: {})

    stub_request(:get, "https://api.github.com/search/commits?q=author:colinwarmstrong+committer-date:>#{date}").to_return(status: 200, body: File.read('./spec/mock_requests/commits.json'))

    visit followings_path

    click_link 'colinwarmstrong'

    expect(current_path).to eq(following_path)
    expect(page).to have_content("colinwarmstrong's Recent Activity")
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
