class Admin::TeamsController < ApplicationController

  add_breadcrumb 'Teams', :admin_teams_path

  def index
    @teams = Team.all.order( :name ).page(params[:page]).per(10)
    authorize! :read, Team
  end

  def show
    @team = Team.find( params[:id] )
    add_breadcrumb @team.name, admin_team_path( @team )
    @users = @team.users.order :name
    @skills = @team.skills.order :name
    authorize! :read, @team
  end

  def new
    add_breadcrumb 'New', :new_admin_team_path
    @users = User.select( :id, :name ).order :name
    @team = Team.new
  end

  def create
    @team = Team.new( team_params )
    @users = User.select( :id, :name ).order :name
    @team.save
    redirect_to admin_teams_path
    authorize! :create, Team
  end

  def destroy
    @team = Team.find( params[:id] )
    authorize! :delete, @team
    @team.destroy
    redirect_to admin_teams_path
  end

  def edit
    @team = Team.find( params[:id] )
    @users = User.select( :id, :name ).order :name
    add_breadcrumb @team.name, admin_team_path( @team )
    add_breadcrumb 'Edit', edit_admin_team_path( @team )
    authorize! :edit, @team
  end

  def update
    @team = Team.find( params[:id] )
    @users = User.select( :id, :name ).order :name
    authorize! :edit, @team
    @team.update( team_params )
    redirect_to admin_teams_path
  end


  private

  def team_params
    params.require( :team ).permit( :name, :user_id )
  end

end
