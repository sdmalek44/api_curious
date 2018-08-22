class FollowersController < ApplicationController
  def index
    @conn = Faraday.new("https://api.github.com") do |faraday|
      faraday.headers['Authorization'] = "token #{current_user.token}"
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("/users/#{current_user.login}/followers")
    followers = JSON.parse(response.body, symbolize_names: true)

    @github_followers = followers.map do |follower_info|
      Follower.new(follower_info)
    end
  end
end
