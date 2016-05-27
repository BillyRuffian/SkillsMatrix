class Admin::TeamsController < ApplicationController
  def index
    @teams = Team.all.order :name
    authorize! :read, Team
  end

  def show
    @team = Team.find( params[:id] )
    @users = @team.users.order :email
    @skills = @team.skills.order :name
    authorize! :read, @team
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new( team_params )
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
    authorize! :edit, @team
  end

  def update
    @team = Team.find( params[:id] )
    authorize! :edit, @team
    @team.update( team_params )
    redirect_to admin_teams_path
  end

  private

  def team_params
    params.require( :team ).permit( :name )
  end

end
