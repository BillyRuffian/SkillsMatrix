class Admin::SkillsController < ApplicationController

  add_breadcrumb 'Skills', :admin_skills_path

  def index
    @skills = Skill.all.order( :name ).page(params[:page]).per(10)
    @skills = add_search @skills
    authorize! :read, Skill
  end

  def show
    @skill = Skill.includes( :claims, :teams ).find params[:id]

    @teams = @skill.teams

    @users_with_skill =
      User.
      joins(:claims).
      joins( "inner join skills on claims.skill_id = skills.id").
      where( "skills.id = ?", @skill.id).
      where( 'claims.level > 1 ' )

    @users_needing_training =
      User.
      joins(:claims).
      joins( "inner join skills on claims.skill_id = skills.id").
      where( "skills.id = ?", @skill.id).
      where( 'claims.level = 1 ' )

    authorize! :read, @skill
    add_breadcrumb @skill.name, admin_skill_path( @skill )
  end

  private

  def add_search skills
    if ! params[:search].blank?
      @search_term = params[:search]
      term = "%#{@search_term}%"
      skills = skills.where( 'name like ?', term )
    end
    skills
  end

end
