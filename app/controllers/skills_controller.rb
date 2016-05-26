class SkillsController < ApplicationController

  def index
    @skills = Skill.joins("left outer join claims on skills.id = claims.skill_id and claims.user_id = #{current_user.id}").order( :name )
    authorize! :read, :skills
  end

end
