class Admin::UsersController < ApplicationController

  add_breadcrumb 'Staff', :admin_users_path

  def index
    @users = User.all.order( :name ).page(params[:page]).per(10)
    @users = add_search @users
    authorize! :read, User
  end

  private

  def add_search users
    if ! params[:search].blank?
      @search_term = params[:search]
      term = "%#{@search_term}%"
      users = users.where( 'name like ?', term )
    end
    users
  end
end
