class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    @conn = Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{current_user.token}"
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("/users/#{current_user.login}/starred")
    repos = JSON.parse(response.body, symbolize_names: true)
    @starred_repos = repos.length
  end

end
