class GithubUser
  attr_reader :login,
              :image,
              :url,
              :token

  def initialize(login, image, url, token = nil)
    @login = login
    @image = image
    @url = url
    @token = token
  end
  
end
