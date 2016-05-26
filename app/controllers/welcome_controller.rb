class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @claims = current_user.claims
    end
  end
end
