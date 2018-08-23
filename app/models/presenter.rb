class Presenter

  def initialize(current_user)
    @service = GithubService.new(current_user)
  end

  def starred_repos
    @service.starred_repos.map do |raw_repo|
      Repository.new(raw_repo)
    end
  end

  def followers
    @service.followers.map do |follower_info|
      GithubUser.new(follower_info)
    end
  end

  def following
    @service.following.map do |following_info|
      GithubUser.new(following_info)
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
