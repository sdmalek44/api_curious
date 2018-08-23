class GithubService

  def initialize(current_user)
    @token = current_user.token
    @login = current_user.login
  end

  def starred_repos
    @starred ||= get_json("/users/#{@login}/starred")
  end

  def followers
    @followers ||= get_json("/users/#{@login}/followers")
  end

  def repositories
      @repositories ||= get_json("/users/#{@login}/repos?page=#{num = 1}")
      while @repositories.length % 30 == 0
        @repositories = (@repositories << get_json("/users/#{@login}/repos?page=#{num += 1}")).flatten
      end
      @repositories
  end

  private

  def conn
    @conn ||= Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
