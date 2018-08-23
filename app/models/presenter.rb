class Presenter
  attr_reader :service

  def initialize(github_user)
    @service = GithubService.new(github_user)
  end

  def starred_repos
    @service.starred_repos.map do |raw_repo|
      Repository.new(raw_repo)
    end
  end

  def followers
    @service.followers.map do |follower|
      GithubUser.new(follower[:login], follower[:avatar_url], follower[:url])
    end
  end

  def following
    @service.following.map do |following|
      GithubUser.new(following[:login], following[:avatar_url], following[:url])
    end
  end

  def repositories
    @service.repositories.map do |repo_info|
      Repository.new(repo_info)
    end
  end

  def recent_commits
    @service.recent_commits.reverse.map do |commit_info|
      Commit.new(commit_info)
    end.shift(10)
  end
end
