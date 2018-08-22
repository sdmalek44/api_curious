class Presenter

  def initialize(current_user)
    @service ||= GithubService.new(current_user)
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
end
