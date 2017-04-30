class RegistrationsController < Devise::RegistrationsController
  private
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:image_url)
  end
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :image_url)
  end
end
