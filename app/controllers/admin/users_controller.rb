class Admin::UsersController < ApplicationController

  add_breadcrumb 'Staff', :admin_users_path

  def index
    @users = User.all.order :name
    authorize! :read, User
  end

end
