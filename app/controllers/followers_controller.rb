class FollowersController < ApplicationController
  def index
    @presenter = Presenter.new(current_user)
  end

  def show
    @presenter = Presenter.new(GithubUser.new(params[:login], nil, nil, current_user.token))
  end
end
