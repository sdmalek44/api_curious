class GithubService
  attr_reader :login

  def initialize(github_user)
    @token = github_user.token
    @login = github_user.login
  end

  def starred_repos
    @starred ||= get_json("/users/#{@login}/starred")
  end

  def followers
    @followers ||= get_json("/users/#{@login}/followers")
  end

  def followings
    @following ||= get_json("/users/#{@login}/following")
  end

  def repositories
      @repositories ||= get_json("/users/#{@login}/repos?page=#{num = 1}")
      while @repositories.length % 30 == 0
        @repositories = (@repositories << get_json("/users/#{@login}/repos?page=#{num += 1}")).flatten
      end
      @repositories
  end

  def recent_commits
    @commits ||= (get_json("/search/commits?q=author:#{@login}+committer-date:>#{3.days.ago.strftime('%Y-%m-%d')}"))[:items]
  end

  def push_events
    @events ||= get_json("/users/#{@login}/events").find_all {|event| event[:type] == "PushEvent"}
  end

  private

  def conn
    @conn ||= Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@token}"
      faraday.headers["Accept"] = "application/vnd.github.cloak-preview"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
