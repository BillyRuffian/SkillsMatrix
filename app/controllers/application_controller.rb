class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_for_new_skills

  add_breadcrumb "<i class='fa fa-home'></i>".html_safe, :root_path

  def check_for_new_skills
    if user_signed_in?
      if ! current_user.first_sign_in?
        @new_skills = Skill.new_since( current_user.last_sign_in_at ).order( :name )
      end
    end
  end
end
