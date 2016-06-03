class Admin::SkillsController < ApplicationController

  autocomplete :skill, :context, scopes: [:unique_types]

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

  def edit
    @skill = Skill.find params[:id]
    authorize! :edit, @skill
    add_breadcrumb @skill.name, admin_skill_path( @skill )
    add_breadcrumb 'Edit', edit_admin_skill_path( @skill )
  end

  def update
    @skill = Skill.find params[:id]
    authorize! :edit, @skill
    @skill.update_attributes skill_params
    flash.notice = "#{@skill.name} updated"
    redirect_to admin_skill_path( @skill )
  end

  def new
    @skill = Skill.new
    authorize! :skill, Skill
    add_breadcrumb 'Edit', new_admin_skill_path
  end

  def create
    authorize! :create, Skill
    @skill = Skill.new skill_params
    if @skill.save
      flash.notice = "#{@skill.name} created"
      redirect_to admin_skill_path( @skill )
    end
  end

  def destroy
    @skill = Skill.find params[:id]
    authorize! :destroy, @skill
    @skill.destroy
    flash.notice = "Skill #{@skill.name} has been deleted"
    redirect_to admin_skills_path
  end

  private

  def skill_params
    params.require( :skill ).permit( :name, :description, :context )
  end

  def add_search skills
    if ! params[:search].blank?
      @search_term = params[:search]
      term = "%#{@search_term}%"
      skills = skills.where( 'name like ? or context like ?', term, term )
    end
    skills
  end

end
