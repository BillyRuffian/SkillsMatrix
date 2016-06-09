class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_mailer_host

  before_action :check_for_new_skills
  before_action :get_team_names

  add_breadcrumb "<i class='fa fa-home'></i>".html_safe, :root_path

  layout :layout_for_resource

  def check_for_new_skills
    if user_signed_in?
      if ! current_user.first_sign_in?
        @new_skills = Skill.new_since( current_user.last_sign_in_at ).order( :name )
      end
    end
  end

  def get_team_names
    @team_names = Team.order( :name )
  end

  protected

  def layout_for_resource
    if devise_controller? && ( ! profile_edit_action? || password_reset_action? )
      "session"
    else
      "application"
    end
  end

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def profile_edit_action?
    controller_name = 'registrations' && ( action_name == 'edit' || action_name == 'update')
  end

  def password_reset_action?
    controller_name = 'passwords' && action_name = 'edit' && ! params[:reset_password_token].blank?
  end
end
