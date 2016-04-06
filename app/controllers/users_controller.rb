class UsersController < ApplicationController
  before_action :authenticate!

  def index
    @users = User.all.order("email")
  end
end
