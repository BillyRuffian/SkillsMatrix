class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @claims = current_user.claims
      @recommended_skills = current_user.recommended_skills.order :name
    end
  end
end
