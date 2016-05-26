module ClaimsHelper
  def claim_to_words claim
    case claim.level
    when :nr       then 'Not required'
    when :training then 'Training needed'
    when :basic    then 'Basic knowledge'
    when :good     then 'Good knowledge'
    when :expert   then 'Expert knowledge'
    else 'Unknown type of need'
    end
  end

  def skill_claim_for_user user, skill
    user.claims.select{ |c| c.skill == skill}.first
  end

  def color_for_claim claim
    if claim
      case claim.level
      when :training then 'bg-red'
      when :basic    then 'bg-light-blue'
      when :good     then 'bg-blue'
      when :expert   then 'bg-navy'
      end
    end
  end

  def icon_for_claim claim
    if claim
      case claim.level
      when :training then 'fa-graduation-cap'
      when :basic    then 'fa-star-o'
      when :good     then 'fa-star-half-empty'
      when :expert   then 'fa-star'
      else 'fa-close'
      end
    else
      'fa-close'
    end
  end

  def link_to_user_skill_claim link_text, skill, claim, params = {}
    if !claim.blank?
      link_to( link_text, skill_claim_path( skill, claim, params ), method: :put, remote: true )
    else
      link_to( link_text, skill_claims_path(skill, params), method: :post, remote: true )
    end
  end
end
