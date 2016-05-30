class Admin::UsersController < ApplicationController

  def index
    @users = User.all.order :name
    authorize! :read, User
  end

end
