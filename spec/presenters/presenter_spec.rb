require 'rails_helper'

describe Presenter do
  it '#starred_repos' do
    VCR.use_cassette('presenter_starred_repos') do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      presenter = Presenter.new(user)

      starred_repos = presenter.starred_repos
      starred_repo = starred_repos.first

      expect(starred_repos.count).to eq(3)
      expect(starred_repo).to be_a(Repository)

      expect(starred_repo.name).to eq("spoke")
      expect(starred_repo.owner).to eq("sdmalek44")
      expect(starred_repo.url).to eq('https://api.github.com/repos/sdmalek44/spoke')
      expect(starred_repo.created_at).to eq("2018-07-19T23:06:03Z")
      expect(starred_repo.updated_at).to eq("2018-08-22T00:51:23Z")
    end
  end
end
