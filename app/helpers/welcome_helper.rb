module WelcomeHelper

  def color_for_claimed_skill( user, user_skills, skill )
    if user_skills.include? skill
      user_claim = skill.claims.for_user( user ).first
      if user_claim.level == :training
        'bg-yellow'
      else
        'bg-green'
      end
    else
      'bg-red'
    end
  end

  def icon_for_claimed_skill( user, user_skills, skill )
    if user_skills.include? skill
      user_claim = skill.claims.for_user( user ).first
      if user_claim.level == :training
        'fa-graduation-cap'
      else
        'fa-check'
      end
    else
      'fa-circle-o'
    end
  end

end
