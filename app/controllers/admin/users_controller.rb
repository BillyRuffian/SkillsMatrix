class Admin::UsersController < ApplicationController

  def index
    @users = User.all.order :email
    authorize! :read, User
  end

end
