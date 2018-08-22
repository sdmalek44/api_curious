class Follower
  attr_reader :login,
              :image

  def initialize(follower_info)
    @login = follower_info[:login]
    @image = follower_info[:avatar_url]
  end
end
