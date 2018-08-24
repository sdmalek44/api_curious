require 'rails_helper'

describe GithubService do
  it '#starred_repos' do
    user = create(:user)
    starred = File.read('./spec/mock_requests/starred.json')
    stub_request(:get, "https://api.github.com/users/#{user.login}/starred").to_return(status: 200, body: starred, headers: {})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    github_user = GithubService.new(user)

    expect(github_user.starred_repos.count).to eq(3)

    repo_info = github_user.starred_repos.first

    expect(repo_info).to have_key(:name)
    expect(repo_info[:owner]).to have_key(:login)
    expect(repo_info).to have_key(:url)
    expect(repo_info).to have_key(:created_at)
    expect(repo_info).to have_key(:updated_at)
  end
end
