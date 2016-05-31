class RegistrationsController < Devise::RegistrationsController

  add_breadcrumb 'Profile', :edit_user_registration_path

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
