class Presenter

  def initialize(current_user)
    @service = GithubService.new(current_user)
    @current_user = current_user
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
    commits = @service.push_events.inject([]) do |collector, event_info|
      if event_info[:payload][:commits]
        event_info[:payload][:commits].each do |commit_info|
          collector << Commit.new(commit_info[:author][:name], event_info[:repo][:name], commit_info[:sha], commit_info[:message], event_info[:created_at]) if commit_info[:author][:name] == @current_user.name
        end
      end
      collector
    end.shift(10)
  end
end
