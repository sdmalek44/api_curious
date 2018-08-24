require 'rails_helper'

describe GithubService do
  it '#starred_repos' do
    VCR.use_cassette('starred_repos') do
      user = create(:user)
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
  it '#followers' do
    VCR.use_cassette('followers') do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      github_user = GithubService.new(user)

      expect(github_user.followers.count).to eq(3)

      user_info = github_user.followers.first
      expect(user_info).to have_key(:login)
      expect(user_info).to have_key(:avatar_url)
      expect(user_info).to have_key(:url)
    end
  end
  it '#followings' do
    VCR.use_cassette('followings') do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      github_user = GithubService.new(user)

      expect(github_user.followings.count).to eq(7)

      user_info = github_user.followings.first
      expect(user_info).to have_key(:login)
      expect(user_info).to have_key(:avatar_url)
      expect(user_info).to have_key(:url)
    end
  end
  it '#organizations' do
    VCR.use_cassette("organizations") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      github_user = GithubService.new(user)

      expect(github_user.organizations.count).to eq(2)
      org_info = github_user.organizations.first
      expect(org_info).to have_key(:login)
      expect(org_info).to have_key(:url)
      expect(org_info).to have_key(:description)
    end
  end
  it '#repositories' do
    VCR.use_cassette("repositories") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      github_user = GithubService.new(user)

      expect(github_user.repositories.count).to eq(40)
      org_info = github_user.repositories.first

      expect(org_info).to have_key(:name)
      expect(org_info).to have_key(:url)
    end
  end
  it '#recent_commits' do
    VCR.use_cassette("recent_commits") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      github_user = GithubService.new(user)

      expect(github_user.recent_commits.count).to eq(21)
      commit_info = github_user.recent_commits.first

      expect(commit_info).to have_key(:author)
      expect(commit_info[:author]).to have_key(:login)
      expect(commit_info).to have_key(:repository)
      expect(commit_info[:repository]).to have_key(:full_name)
      expect(commit_info).to have_key(:sha)
      expect(commit_info).to have_key(:commit)
      expect(commit_info[:commit]).to have_key(:message)
      expect(commit_info[:commit]).to have_key(:author)
      expect(commit_info[:commit][:author]).to have_key(:date)
    end
  end
end
