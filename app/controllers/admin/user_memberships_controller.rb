class Admin::UserMembershipsController < ApplicationController

  add_breadcrumb 'Users', :admin_users_path


  def index
    @teams = add_search( Team.all.order(:name).page(params[:page]).per(10) )
    @user = User.includes(:teams).find( params[:user_id] )

    add_breadcrumb @user.name, admin_user_path( @user )
    add_breadcrumb 'Teams', admin_user_teams_path( @user )

    authorize! :read, @user
  end

  def update
    @team = Team.find params[:id]
    @user = User.find params[:user_id]

    authorize! :read, @team
    authorize! :assign, @user

    @user.teams << @team unless @user.member_of? @team

    SendTeamChangedEmailJob.perform_async @user, current_user
    render 'update_membership' unless performed?
  end

  def destroy
    @team = Team.find params[:id]
    @user = User.find params[:user_id]

    authorize! :read, @team
    authorize! :assign, @user

    @team.users.delete( @user )
    @user.reload
    render 'update_membership'
  end

  private

  def add_search teams
    if ! params[:search].blank?
      @search_term = params[:search]
      term = "%#{@search_term}%"
      teams = teams.where( 'name like ?', term )
    end
    teams
  end

end
