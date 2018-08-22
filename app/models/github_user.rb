class GithubUser
  attr_reader :login,
              :image,
              :url

  def initialize(follower_info)
    @login = follower_info[:login]
    @image = follower_info[:avatar_url]
    @url = follower_info[:url]
  end
end
