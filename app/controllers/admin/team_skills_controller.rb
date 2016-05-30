class Admin::TeamSkillsController < ApplicationController

  def index
    @team = Team.includes( :skills ).find( params[:team_id] )
    @skills = Skill.includes( :users ).order(:name).page(params[:page]).per(10)
    @skills = add_search @skills
  end

  def update
    @team = Team.find params[:team_id]
    @skill = Skill.find params[:id]
    @team.skills << @skill
    @skill.reload
    render 'update_skill' unless performed?
  end

  def destroy
    @team = Team.find params[:team_id]
    @skill = Skill.find params[:id]
    @skill.teams.delete( @team )
    @team.reload
    render 'update_skill'
  end

  private

  def add_search skills
    if ! params[:search].blank?
      @search_term = params[:search]
      term = "%#{@search_term}%"
      skills = skills.where( 'name like ? OR description like ? OR context like ?', term, term, term )
    end
    skills
  end

end
