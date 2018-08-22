class Presenter

  def initialize(current_user)
    @token = current_user.token
    @login = current_user.login
    @service ||= GithubService.new(current_user)
  end

  def starred_repos
    @service.starred_repos.map do |raw_repo|
      Repository.new(raw_repo)
    end
  end
end
