class ClaimsController < ApplicationController

  def create
    @skill = Skill.find params[:skill_id]
    if user_signed_in?
      claim = current_user.claims.build
      claim.skill = @skill
      claim.level = params[:level]
      claim.save
    end
    render :update_skill
    authorize! :create, Claim
  end

  def update
    @skill = Skill.find params[:skill_id]
    if user_signed_in?
      @claim = current_user.claims.find( params[:id] )
      if params[:level].to_sym == :nr
        @claim.delete
        authorize! :delete, @claim
      else
        @claim.level = params[:level]
        @claim.save
        authorize! :update, @claim
      end
    end
    render :update_skill
  end

end
