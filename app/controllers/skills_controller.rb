class SkillsController < ApplicationController

  def index
    @skills = Skill.joins(
      "left outer join claims on skills.id = claims.skill_id and claims.user_id = #{current_user.id}").
      order( :name ).
      page( params[:page] ).per 10
    @skills = add_search @skills
    authorize! :read, :skills
    add_breadcrumb 'All skills', skills_path
  end

  def recommended
    @skills = current_user.recommended_skills.order(:name).page( params[:page] ).per 10
    @skills = add_search @skills
    @teams  = current_user.teams
    authorize! :read, :skills
    add_breadcrumb 'Recommended skills', recommended_skills_path
  end

  def recent
    @skills = @new_skills.page( params[:page] ).per 10
    @skills = add_search @skills
    add_breadcrumb 'Recent skills', recent_skills_path
  end

  def your_skills
    @skills = current_user.skills_claimed.page( params[:page] ).per 10
    @skills = add_search @skills
    add_breadcrumb 'Your skills', your_skills_path
  end
  alias_method :your, :your_skills

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
