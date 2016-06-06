class Admin::UsersController < ApplicationController

  add_breadcrumb 'Staff', :admin_users_path

  def index
    @users = User.all.order( :name ).page(params[:page]).per(10)
    @users = add_search @users
    authorize! :read, User
  end

  def show
    @user = User.find params[:id]
    @teams = @user.teams.includes(:skills).order :name
    @claims = @user.claims.includes(:skill).order('skills.name')
    add_breadcrumb @user.name, admin_user_path( @user )
    authorize! :read, @user
  end

  def edit
    @user = User.find params[:id]
    add_breadcrumb @user.name, admin_user_path( @user )
    add_breadcrumb 'Edit', edit_admin_user_path( @user )
    authorize! :edit, @user
  end

  def update
    @user = User.find params[:id]
    authorize! :edit, @user
    @user.update_attributes user_params
    flash.notice = "#{@user.name} has been updated"
    redirect_to admin_user_path( @user )
  end

  def destroy
    @user = User.find params[:id]
    authorize! :destroy, @user
    @user.destroy
    flash.notice = "#{@user.name} has been deleted"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require( :user ).permit( :name, :email, :password, :password_confirmation, :admin )
  end

  def add_search users
    if ! params[:search].blank?
      @search_term = params[:search]
      term = "%#{@search_term}%"
      users = users.where( 'name like ?', term )
    end
    users
  end
end
