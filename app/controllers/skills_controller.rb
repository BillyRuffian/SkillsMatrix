class SkillsController < ApplicationController

  def index
    @skills = Skill.joins('left outer join claims on skills.id = claims.skill_id').where( 'claims.user_id = ? or claims.user_id is null', 1 ).order( :name )
  end

end
