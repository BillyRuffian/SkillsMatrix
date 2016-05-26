class Admin::TeamsController < ApplicationController
  def index
    @teams = Team.all.order :name
    authorize! :read, Team
  end

  def show
    @team = Team.find( params[:id] )
    @users = @team.users
    @skills = @team.skills
    authorize! :read, @team
  end
end
