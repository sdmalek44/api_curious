class Presenter

  def initialize(current_user)
    @token = current_user.token
    @login = current_user.login
  end

  def starred_repos
    @conn = Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("/users/#{@login}/starred")
    raw_repos = JSON.parse(response.body, symbolize_names: true)

    raw_repos.map do |raw_repo|
      Repository.new(raw_repo)
    end
  end
end
