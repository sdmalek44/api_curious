class User < ApplicationRecord
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.name = auth[:info][:name]
      user.token = auth[:credentials][:token]
      user.image = auth[:extra][:raw_info][:avatar_url]
      user.login = auth[:extra][:raw_info][:login]
    end
  end

end
